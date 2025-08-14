// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome to CarStore`
  String get welcome_to_carStore {
    return Intl.message(
      'Welcome to CarStore',
      name: 'welcome_to_carStore',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Forgot Password?`
  String get forgot_password {
    return Intl.message(
      'Forgot Password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Don’t have an account`
  String get dont_have_an_account {
    return Intl.message(
      'Don’t have an account',
      name: 'dont_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get sign_up {
    return Intl.message('Sign Up', name: 'sign_up', desc: '', args: []);
  }

  /// `Find your dream car`
  String get find_your_dream_car {
    return Intl.message(
      'Find your dream car',
      name: 'find_your_dream_car',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get full_name {
    return Intl.message('Full name', name: 'full_name', desc: '', args: []);
  }

  /// `Email address`
  String get email_address {
    return Intl.message(
      'Email address',
      name: 'email_address',
      desc: '',
      args: [],
    );
  }

  /// `Phone number 1`
  String get phone_number1 {
    return Intl.message(
      'Phone number 1',
      name: 'phone_number1',
      desc: '',
      args: [],
    );
  }

  /// `Phone number 2`
  String get phone_number2 {
    return Intl.message(
      'Phone number 2',
      name: 'phone_number2',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get already_have_an_account {
    return Intl.message(
      'Already have an account?',
      name: 'already_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get sign_in {
    return Intl.message('Sign In', name: 'sign_in', desc: '', args: []);
  }

  /// `Send link`
  String get send_link {
    return Intl.message('Send link', name: 'send_link', desc: '', args: []);
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Login Now`
  String get login_now {
    return Intl.message('Login Now', name: 'login_now', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Winner`
  String get winner {
    return Intl.message('Winner', name: 'winner', desc: '', args: []);
  }

  /// `Follow us on`
  String get follow_us_on {
    return Intl.message(
      'Follow us on',
      name: 'follow_us_on',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Car Store`
  String get welcome_to_car_store {
    return Intl.message(
      'Welcome to Car Store',
      name: 'welcome_to_car_store',
      desc: '',
      args: [],
    );
  }

  /// `Company Name`
  String get company_name {
    return Intl.message(
      'Company Name',
      name: 'company_name',
      desc: '',
      args: [],
    );
  }

  /// `Login as`
  String get login_as {
    return Intl.message('Login as', name: 'login_as', desc: '', args: []);
  }

  /// `Company`
  String get company {
    return Intl.message('Company', name: 'company', desc: '', args: []);
  }

  /// `Buyer`
  String get buyer {
    return Intl.message('Buyer', name: 'buyer', desc: '', args: []);
  }

  /// `Complete Registration`
  String get complete_registration {
    return Intl.message(
      'Complete Registration',
      name: 'complete_registration',
      desc: '',
      args: [],
    );
  }

  /// `Search for ................`
  String get search_for_honda_pilot_7_passenger {
    return Intl.message(
      'Search for ................',
      name: 'search_for_honda_pilot_7_passenger',
      desc: '',
      args: [],
    );
  }

  /// `Recommended`
  String get recommended {
    return Intl.message('Recommended', name: 'recommended', desc: '', args: []);
  }

  /// `See all`
  String get see_all {
    return Intl.message('See all', name: 'see_all', desc: '', args: []);
  }

  /// `Enter your name`
  String get enter_your_name {
    return Intl.message(
      'Enter your name',
      name: 'enter_your_name',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get enter_your_email {
    return Intl.message(
      'Enter your email',
      name: 'enter_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get enter_your_password {
    return Intl.message(
      'Enter your password',
      name: 'enter_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `Enter your address`
  String get enter_your_address {
    return Intl.message(
      'Enter your address',
      name: 'enter_your_address',
      desc: '',
      args: [],
    );
  }

  /// `Who are we`
  String get who_are_we {
    return Intl.message('Who are we', name: 'who_are_we', desc: '', args: []);
  }

  /// `Privacy policy`
  String get privacy_policy {
    return Intl.message(
      'Privacy policy',
      name: 'privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `Share the app`
  String get share_the_app {
    return Intl.message(
      'Share the app',
      name: 'share_the_app',
      desc: '',
      args: [],
    );
  }

  /// `Show car for sale`
  String get show_car_for_sale {
    return Intl.message(
      'Show car for sale',
      name: 'show_car_for_sale',
      desc: '',
      args: [],
    );
  }

  /// `Almost there!`
  String get almost_there {
    return Intl.message(
      'Almost there!',
      name: 'almost_there',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `New`
  String get new1 {
    return Intl.message('New', name: 'new1', desc: '', args: []);
  }

  /// `Used`
  String get used1 {
    return Intl.message('Used', name: 'used1', desc: '', args: []);
  }

  /// `Model`
  String get Model {
    return Intl.message('Model', name: 'Model', desc: '', args: []);
  }

  /// `Phone`
  String get phone {
    return Intl.message('Phone', name: 'phone', desc: '', args: []);
  }

  /// `Price Range`
  String get PriceRange {
    return Intl.message('Price Range', name: 'PriceRange', desc: '', args: []);
  }

  /// `Min Price`
  String get min_price {
    return Intl.message('Min Price', name: 'min_price', desc: '', args: []);
  }

  /// `Max Price`
  String get max_price {
    return Intl.message('Max Price', name: 'max_price', desc: '', args: []);
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Creator`
  String get Creator {
    return Intl.message('Creator', name: 'Creator', desc: '', args: []);
  }

  /// `Alarm`
  String get Alarm {
    return Intl.message('Alarm', name: 'Alarm', desc: '', args: []);
  }

  /// `Cruise Control`
  String get CruiseControl {
    return Intl.message(
      'Cruise Control',
      name: 'CruiseControl',
      desc: '',
      args: [],
    );
  }

  /// `Bluetooth`
  String get Bluetooth {
    return Intl.message('Bluetooth', name: 'Bluetooth', desc: '', args: []);
  }

  /// `Front Parking Sensor`
  String get FrontParkingSensor {
    return Intl.message(
      'Front Parking Sensor',
      name: 'FrontParkingSensor',
      desc: '',
      args: [],
    );
  }

  /// `Place Bid`
  String get PlaceBid {
    return Intl.message('Place Bid', name: 'PlaceBid', desc: '', args: []);
  }

  /// `Subscrib`
  String get Subscrib {
    return Intl.message('Subscrib', name: 'Subscrib', desc: '', args: []);
  }

  /// `Enter Bid Price`
  String get EnterBidPrice {
    return Intl.message(
      'Enter Bid Price',
      name: 'EnterBidPrice',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a price greater than the current price`
  String get PleaseRnterAPrice {
    return Intl.message(
      'Please enter a price greater than the current price',
      name: 'PleaseRnterAPrice',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a price`
  String get PleaseEnterPrice {
    return Intl.message(
      'Please enter a price',
      name: 'PleaseEnterPrice',
      desc: '',
      args: [],
    );
  }

  /// `Bid`
  String get Bid {
    return Intl.message('Bid', name: 'Bid', desc: '', args: []);
  }

  /// `Cancel`
  String get Cancel {
    return Intl.message('Cancel', name: 'Cancel', desc: '', args: []);
  }

  /// `Description`
  String get Description {
    return Intl.message('Description', name: 'Description', desc: '', args: []);
  }

  /// `Features`
  String get Features {
    return Intl.message('Features', name: 'Features', desc: '', args: []);
  }

  /// `Go To Map`
  String get GoToMap {
    return Intl.message('Go To Map', name: 'GoToMap', desc: '', args: []);
  }

  /// `Sell`
  String get sell {
    return Intl.message('Sell', name: 'sell', desc: '', args: []);
  }

  /// `success`
  String get success {
    return Intl.message('success', name: 'success', desc: '', args: []);
  }

  /// `Logout`
  String get Logout {
    return Intl.message('Logout', name: 'Logout', desc: '', args: []);
  }

  /// `Offer a car for auction`
  String get OfferACarForAuction {
    return Intl.message(
      'Offer a car for auction',
      name: 'OfferACarForAuction',
      desc: '',
      args: [],
    );
  }

  /// `Car Data`
  String get CarData {
    return Intl.message('Car Data', name: 'CarData', desc: '', args: []);
  }

  /// `Error`
  String get error {
    return Intl.message('Error', name: 'error', desc: '', args: []);
  }

  /// `select date`
  String get select_date {
    return Intl.message('select date', name: 'select_date', desc: '', args: []);
  }

  /// `Title`
  String get Title {
    return Intl.message('Title', name: 'Title', desc: '', args: []);
  }

  /// `Condition`
  String get Condition {
    return Intl.message('Condition', name: 'Condition', desc: '', args: []);
  }

  /// `Enter title`
  String get EnterTitle {
    return Intl.message('Enter title', name: 'EnterTitle', desc: '', args: []);
  }

  /// `Enter Model`
  String get EnterModel {
    return Intl.message('Enter Model', name: 'EnterModel', desc: '', args: []);
  }

  /// `Auction end date`
  String get AuctionEndDate {
    return Intl.message(
      'Auction end date',
      name: 'AuctionEndDate',
      desc: '',
      args: [],
    );
  }

  /// `Please select auction date`
  String get Please_select_date {
    return Intl.message(
      'Please select auction date',
      name: 'Please_select_date',
      desc: '',
      args: [],
    );
  }

  /// `Please select 3 images`
  String get Please_select_3_images {
    return Intl.message(
      'Please select 3 images',
      name: 'Please_select_3_images',
      desc: '',
      args: [],
    );
  }

  /// `price`
  String get price {
    return Intl.message('price', name: 'price', desc: '', args: []);
  }

  /// `All fields are required`
  String get All_fields_are_required {
    return Intl.message(
      'All fields are required',
      name: 'All_fields_are_required',
      desc: '',
      args: [],
    );
  }

  /// `Sell Your Car`
  String get Sell_Your_Car {
    return Intl.message(
      'Sell Your Car',
      name: 'Sell_Your_Car',
      desc: '',
      args: [],
    );
  }

  /// `Upload 3 images`
  String get Upload3images {
    return Intl.message(
      'Upload 3 images',
      name: 'Upload3images',
      desc: '',
      args: [],
    );
  }

  /// `Enter Mobile Number`
  String get EnterMobileNumber {
    return Intl.message(
      'Enter Mobile Number',
      name: 'EnterMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter Price`
  String get EnterPrice {
    return Intl.message('Enter Price', name: 'EnterPrice', desc: '', args: []);
  }

  /// `My Data`
  String get MyData {
    return Intl.message('My Data', name: 'MyData', desc: '', args: []);
  }

  /// `Write description about your car`
  String get Write_description_about_your_car {
    return Intl.message(
      'Write description about your car',
      name: 'Write_description_about_your_car',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Number`
  String get MobileNumber {
    return Intl.message(
      'Mobile Number',
      name: 'MobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Used and New Cars Sales App with Auction`
  String get titleOnboarding1 {
    return Intl.message(
      'Used and New Cars Sales App with Auction',
      name: 'titleOnboarding1',
      desc: '',
      args: [],
    );
  }

  /// `The app allows you to easily buy and sell used and new cars, with the option to participate in auctions for the best deals.`
  String get descriptionOnboarding1 {
    return Intl.message(
      'The app allows you to easily buy and sell used and new cars, with the option to participate in auctions for the best deals.',
      name: 'descriptionOnboarding1',
      desc: '',
      args: [],
    );
  }

  /// `Comprehensive Platform for Buying and Selling Cars`
  String get titleOnboarding2 {
    return Intl.message(
      'Comprehensive Platform for Buying and Selling Cars',
      name: 'titleOnboarding2',
      desc: '',
      args: [],
    );
  }

  /// `Browse used and new cars, and join auctions to seize ideal opportunities, all in one easy-to-use app.`
  String get descriptionOnboarding2 {
    return Intl.message(
      'Browse used and new cars, and join auctions to seize ideal opportunities, all in one easy-to-use app.',
      name: 'descriptionOnboarding2',
      desc: '',
      args: [],
    );
  }

  /// `All-in-One Car App with Auction Feature`
  String get titleOnboarding3 {
    return Intl.message(
      'All-in-One Car App with Auction Feature',
      name: 'titleOnboarding3',
      desc: '',
      args: [],
    );
  }

  /// `Buy or sell your car smoothly, and take advantage of live auctions to get the best deals in the market.`
  String get descriptionOnboarding3 {
    return Intl.message(
      'Buy or sell your car smoothly, and take advantage of live auctions to get the best deals in the market.',
      name: 'descriptionOnboarding3',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
