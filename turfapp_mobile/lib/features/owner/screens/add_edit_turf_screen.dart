import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/models/turf_model.dart';
import '../../../features/auth/providers/auth_provider.dart';
import '../providers/owner_provider.dart';

const _allSports = ['Football', 'Cricket', 'Basketball'];

class AddEditTurfScreen extends ConsumerStatefulWidget {
  final TurfModel? existingTurf; // null = add mode

  const AddEditTurfScreen({super.key, this.existingTurf});

  @override
  ConsumerState<AddEditTurfScreen> createState() => _AddEditTurfScreenState();
}

class _AddEditTurfScreenState extends ConsumerState<AddEditTurfScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _contact1Ctrl = TextEditingController();
  final _contact2Ctrl = TextEditingController();
  final _priceCtrl = TextEditingController();

  final Set<String> _selectedSports = {};
  final List<File> _pickedImages = [];
  final ImagePicker _picker = ImagePicker();

  bool get _isEditing => widget.existingTurf != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      final t = widget.existingTurf!;
      _nameCtrl.text = t.name;
      _addressCtrl.text = t.address;
      _contact1Ctrl.text = t.contact1;
      _contact2Ctrl.text = t.contact2 ?? '';
      _priceCtrl.text = t.pricePerSlot.toStringAsFixed(0);
      _selectedSports.addAll(t.sports);
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _addressCtrl.dispose();
    _contact1Ctrl.dispose();
    _contact2Ctrl.dispose();
    _priceCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    final List<XFile> images = await _picker.pickMultiImage(imageQuality: 75);
    if (images.isNotEmpty) {
      setState(() {
        _pickedImages.addAll(images.map((x) => File(x.path)));
        if (_pickedImages.length > 3) {
          _pickedImages.removeRange(3, _pickedImages.length);
        }
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedSports.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select at least one sport.')),
      );
      return;
    }
    if (!_isEditing && _pickedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Add at least one turf photo.')),
      );
      return;
    }

    final uid = ref.read(authStateProvider).valueOrNull?.uid ?? '';
    final turf = TurfModel(
      id: widget.existingTurf?.id ?? '',
      name: _nameCtrl.text.trim(),
      address: _addressCtrl.text.trim(),
      ownerUid: uid,
      contact1: _contact1Ctrl.text.trim(),
      contact2: _contact2Ctrl.text.trim().isEmpty
          ? null
          : _contact2Ctrl.text.trim(),
      sports: _selectedSports.toList(),
      pricePerSlot: double.tryParse(_priceCtrl.text.trim()) ?? 0,
      imageUrls: widget.existingTurf?.imageUrls ?? [],
      createdAt: widget.existingTurf?.createdAt ?? DateTime.now(),
    );

    bool success;
    if (_isEditing) {
      success = await ref.read(turfNotifierProvider.notifier).updateTurf(
            turf: turf,
            newImageFiles: _pickedImages.isNotEmpty ? _pickedImages : null,
          );
    } else {
      success = await ref.read(turfNotifierProvider.notifier).addTurf(
            turf: turf,
            imageFiles: _pickedImages,
          );
    }

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                _isEditing ? 'Turf updated!' : 'Turf listed successfully!')),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final turfState = ref.watch(turfNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Turf' : 'List a Turf'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionLabel(context, 'Turf Photos'),
              const SizedBox(height: 10),
              _buildImageSection(),
              const SizedBox(height: 24),
              _sectionLabel(context, 'Details'),
              const SizedBox(height: 12),
              _field(_nameCtrl, 'Turf name',
                  validator: _required('Turf name')),
              const SizedBox(height: 12),
              _field(_addressCtrl, 'Full address',
                  validator: _required('Address')),
              const SizedBox(height: 12),
              _field(_priceCtrl, 'Price per slot (₹)',
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Enter a price';
                    if (double.tryParse(v) == null) {
                      return 'Enter a valid number';
                    }
                    return null;
                  }),
              const SizedBox(height: 24),
              _sectionLabel(context, 'Contact'),
              const SizedBox(height: 12),
              _field(_contact1Ctrl, 'Primary phone',
                  keyboardType: TextInputType.phone,
                  validator: _required('Primary phone')),
              const SizedBox(height: 12),
              _field(_contact2Ctrl, 'Secondary phone (optional)',
                  keyboardType: TextInputType.phone),
              const SizedBox(height: 24),
              _sectionLabel(context, 'Sports'),
              const SizedBox(height: 12),
              _buildSportSelector(),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: turfState.isLoading ? null : _submit,
                child: turfState.isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: AppColors.onAccent),
                      )
                    : Text(_isEditing ? 'Update Turf' : 'List Turf'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Column(
      children: [
        if (_pickedImages.isNotEmpty)
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _pickedImages.length,
              itemBuilder: (_, i) => Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: FileImage(_pickedImages[i]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 14,
                    child: GestureDetector(
                      onTap: () =>
                          setState(() => _pickedImages.removeAt(i)),
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          color: AppColors.error,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close,
                            size: 13, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (_pickedImages.isNotEmpty) const SizedBox(height: 10),
        if (_pickedImages.length < 3)
          GestureDetector(
            onTap: _pickImages,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: AppColors.divider, style: BorderStyle.solid),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_photo_alternate_outlined,
                      color: AppColors.textDisabled, size: 22),
                  SizedBox(width: 8),
                  Text('Add Photos (max 3)',
                      style: TextStyle(color: AppColors.textDisabled)),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSportSelector() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: _allSports.map((sport) {
        final selected = _selectedSports.contains(sport);
        return GestureDetector(
          onTap: () => setState(() {
            if (selected) {
              _selectedSports.remove(sport);
            } else {
              _selectedSports.add(sport);
            }
          }),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: selected ? AppColors.accent : AppColors.surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: selected ? AppColors.accent : AppColors.divider),
            ),
            child: Text(
              sport,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: selected ? AppColors.onAccent : AppColors.textSecondary,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _sectionLabel(BuildContext context, String label) {
    return Text(label,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: AppColors.textSecondary, fontSize: 13));
  }

  Widget _field(
    TextEditingController ctrl,
    String hint, {
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: ctrl,
      keyboardType: keyboardType,
      style: const TextStyle(color: AppColors.textPrimary),
      decoration: InputDecoration(hintText: hint),
      validator: validator,
    );
  }

  String? Function(String?) _required(String field) =>
      (v) => (v == null || v.isEmpty) ? 'Enter $field' : null;
}
