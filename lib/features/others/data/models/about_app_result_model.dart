import 'package:json_annotation/json_annotation.dart';
import 'package:ojos_app/core/models/base_model.dart';
import 'package:ojos_app/features/others/domain/entity/about_app_result.dart';

part 'about_app_result_model.g.dart';

@JsonSerializable()
class AboutAppResultModel extends BaseModel<AboutAppResult> {
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
  final VideoHomeResultModel? videoHome;
  final SettingsAppResultModel? settings;

  AboutAppResultModel({
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

  Map<String?, dynamic> toJson() => _$AboutAppResultModelToJson(this);

  factory AboutAppResultModel.fromJson(Map<String, dynamic> json) =>
      _$AboutAppResultModelFromJson(json);

  @override
  AboutAppResult toEntity() {
    return AboutAppResult(
      fax: this.fax,
      email: this.email,
      phone: this.phone,
      mobile: this.mobile,
      address: this.address,
      facebook: this.facebook,
      instagram: this.instagram,
      settings: this.settings != null
          ? this.settings?.toEntity()
          : SettingsAppResult(
             // currency_right: null,
              default_currency: null,
              default_tax: null,
              // enable_paypal: null,
              // enable_stripe: null,
              fee_delivery: null,
              google_maps_key: null),
      site_desc: this.site_desc,
      site_name: this.site_name,
      videoHome: this.videoHome != null
          ? this.videoHome?.toEntity()
          : VideoHomeResult(
              title: null, details: null, link_url: null, video_link: null),
      whatsapp: this.whatsapp,
      youtube: this.youtube,
      twitter: this.twitter,
    );
  }
}

@JsonSerializable()
class VideoHomeResultModel extends BaseModel<VideoHomeResult> {
  final String? title;
  final String? details;
  final String? video_link;
  final String? link_url;

  VideoHomeResultModel({
    required this.title,
    required this.details,
    required this.link_url,
    required this.video_link,
  });

  Map<String?, dynamic> toJson() => _$VideoHomeResultModelToJson(this);

  factory VideoHomeResultModel.fromJson(Map<String, dynamic> json) =>
      _$VideoHomeResultModelFromJson(json);

  @override
  VideoHomeResult toEntity() {
    return VideoHomeResult(
      title: this.title,
      details: this.details,
      link_url: this.link_url,
      video_link: this.video_link,
    );
  }
}

@JsonSerializable()
class SettingsAppResultModel extends BaseModel<SettingsAppResult> {
  final String? enable_stripe;
  final String? default_tax;
  final String? default_currency;
  final String? enable_paypal;
  final String? google_maps_key;
  final String? fee_delivery;
  final String? currency_right;

  SettingsAppResultModel({
    required this.currency_right,
    required this.default_currency,
    required this.default_tax,
    required this.enable_paypal,
    required this.enable_stripe,
    required this.fee_delivery,
    required this.google_maps_key,
  });

  Map<String?, dynamic> toJson() => _$SettingsAppResultModelToJson(this);

  factory SettingsAppResultModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsAppResultModelFromJson(json);

  @override
  SettingsAppResult toEntity() {
    return SettingsAppResult(
     // currency_right: this.currency_right,
      default_currency: this.default_currency,
      default_tax: this.default_tax,
 /*     enable_paypal: this.enable_paypal,
      enable_stripe: this.enable_stripe,*/
      fee_delivery: this.fee_delivery,
      google_maps_key: this.google_maps_key,
    );
  }
}
