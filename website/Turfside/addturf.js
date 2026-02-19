/*global $, document, window, setTimeout, navigator, console, location*/
$(document).ready(function () {

    'use strict';

    var nameError = true,
        phoneoneError = true,
        phonetwoError = true,
        emailError    = true,
        addressError   = true;
        // sportsError = true,
        // passConfirm   = true;

    // Detect browser for css purpose
    if (navigator.userAgent.toLowerCase().indexOf('firefox') > -1) {
        $('.form form label').addClass('fontSwitch');
    }

    // Label effect
    $('input').focus(function () {

        $(this).siblings('label').addClass('active');
    });

    // Form validation
    $('input').blur(function () {

        // User Name
        if ($(this).hasClass('name')) {
            if ($(this).val().length === 0) {
                $(this).siblings('span.error').text('Please type your full name').fadeIn().parent('.form-group').addClass('hasError');
                nameError = true;
            } else if ($(this).val().length > 1 && $(this).val().length <= 6) {
                $(this).siblings('span.error').text('Please type at least 6 characters').fadeIn().parent('.form-group').addClass('hasError');
                nameError = true;
            } else {
                $(this).siblings('.error').text('').fadeOut().parent('.form-group').removeClass('hasError');
                nameError = false;
            }
        }
        // Email
        if ($(this).hasClass('email')) {
            if ($(this).val().length == '') {
                $(this).siblings('span.error').text('Please type your email address').fadeIn().parent('.form-group').addClass('hasError');
                emailError = true;
            } else {
                $(this).siblings('.error').text('').fadeOut().parent('.form-group').removeClass('hasError');
                emailError = false;
            }
        }

        // Phone Number
        if ($(this).hasClass('contact1')) {
            if ($(this).val().length == "") {
                $(this).siblings('span.error').text('Please type your Phone Number').fadeIn().parent('.form-group').addClass('hasError');
                phoneoneError = true;
            } else if ( $(this).val().length != 10) {
                $(this).siblings('span.error').text('Please type Correct Phone Number').fadeIn().parent('.form-group').addClass('hasError');
                phoneoneError = true;
            } else {
                $(this).siblings('.error').text('').fadeOut().parent('.form-group').removeClass('hasError');
                phoneoneError = false;
            }
        }

        if ($(this).hasClass('contact2')) {
            if ($(this).val().length == "") {
                $(this).siblings('span.error').text('Please type your Phone Number').fadeIn().parent('.form-group').addClass('hasError');
                phonetwoError = true;
            } else if ( $(this).val().length != 10) {
                $(this).siblings('span.error').text('Please type Correct Phone Number').fadeIn().parent('.form-group').addClass('hasError');
                phonetwoError = true;
            } else {
                $(this).siblings('.error').text('').fadeOut().parent('.form-group').removeClass('hasError');
                phonetwoError = false;
            }
        }

        // Address 
        if ($(this).hasClass('address')) {
            if ($(this).val().length === 0) {
                $(this).siblings('span.error').text('Please type your Address').fadeIn().parent('.form-group').addClass('hasError');
                addressError = true;
            } else if ($(this).val().length > 1 && $(this).val().length <= 6) {
                $(this).siblings('span.error').text('Please type at least 6 characters').fadeIn().parent('.form-group').addClass('hasError');
                addressError = true;
            } else {
                $(this).siblings('.error').text('').fadeOut().parent('.form-group').removeClass('hasError');
                addressError = false;
            }
        }

        // PassWord
        if ($(this).hasClass('pass')) {
            if ($(this).val().length < 8) {
                $(this).siblings('span.error').text('Please type at least 8 charcters').fadeIn().parent('.form-group').addClass('hasError');
                passwordError = true;
            } else {
                $(this).siblings('.error').text('').fadeOut().parent('.form-group').removeClass('hasError');
                passwordError = false;
            }
        }
    });


    // // form switch
    // $('a.switch').click(function (e) {
    //     $(this).toggleClass('active');
    //     e.preventDefault();

    //     if ($('a.switch').hasClass('active')) {
    //         $(this).parents('.form-peice').addClass('switched').siblings('.form-peice').removeClass('switched');
    //     } else {
    //         $(this).parents('.form-peice').removeClass('switched').siblings('.form-peice').addClass('switched');
    //     }
    // });


    // Form submit
    $('form.signup-form').submit(function (event) {
        event.preventDefault();

        if (nameError == true || emailError == true || phoneoneError == true || phonetwoError == true || addressError == true) {
            $('.name, .email, .contact1, .contact2, .address').blur();
        } else {
            $('.signup, .login').addClass('switched');

            setTimeout(function () { $('.signup, .login').hide(); }, 700);
            setTimeout(function () { $('.brand').addClass('active'); }, 300);
            setTimeout(function () { $('.heading').addClass('active'); }, 600);
            setTimeout(function () { $('.success-msg p').addClass('active'); }, 900);
            setTimeout(function () { $('.success-msg a').addClass('active'); }, 1050);
            setTimeout(function () { $('.form').hide(); }, 700);
        }
    });

    // Reload page
    $('a.profile').on('click', function () {
        location.reload(true);
    });


});