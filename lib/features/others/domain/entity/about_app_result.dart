import 'package:ojos_app/core/entities/base_entity.dart';

class AboutAppResult extends BaseEntity {
  final String? site_name;
  final String? site_desc;
  final String? address;
  final String? mobile;
  final String? phone;
  final String? email;
  final String? fax;
  final String? facebook;
  final String? twitter;
  final String? youtube;
  final String? instagram;
  final String? whatsapp;
  final VideoHomeResult? videoHome;
  final SettingsAppResult? settings;

  AboutAppResult({
    required this.settings,
    required this.email,
    required this.phone,
    required this.mobile,
    required this.address,
    required this.facebook,
    required this.instagram,
    required this.fax,
    required this.twitter,
    required this.site_desc,
    required this.site_name,
    required this.whatsapp,
    required this.videoHome,
    required this.youtube,
  });

  @override
  List<Object> get props => [
        settings ?? '',
        email ?? '',
        phone ?? '',
        mobile ?? '',
        address ?? '',
        facebook ?? '',
        instagram ?? '',
        fax ?? '',
        twitter ?? '',
        site_desc ?? '',
        site_name ?? '',
        whatsapp ?? '',
        videoHome ?? '',
        youtube ?? '',
      ];
}

class VideoHomeResult extends BaseEntity {
  final String? title;
  final String? details;
  final String? video_link;
  final String? link_url;

  VideoHomeResult({
    required this.title,
    required this.details,
    required this.link_url,
    required this.video_link,
  });

  @override
  List<Object> get props => [
        title ?? '',
        details ?? '',
        link_url ?? '',
        video_link ?? '',
      ];
}

class SettingsAppResult extends BaseEntity {
 // final String? enable_stripe;
  final String? default_tax;
  final String? default_currency;
 // final String? enable_paypal;
  final String? google_maps_key;
  final String? fee_delivery;
 // final String? currency_right;

  SettingsAppResult({
  //  required this.currency_right,
    required this.default_currency,
    required this.default_tax,
    // required this.enable_paypal,
    // required this.enable_stripe,
    required this.fee_delivery,
    required this.google_maps_key,
  });

  @override
  List<Object> get props => [
       // currency_right ?? '',
        default_currency ?? '',
        default_tax ?? '',
        // enable_paypal ?? '',
        // enable_stripe ?? '',
        fee_delivery ?? '',
        google_maps_key ?? '',
      ];
}
