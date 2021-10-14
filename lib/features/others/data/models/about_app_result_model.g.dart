// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'about_app_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AboutAppResultModel _$AboutAppResultModelFromJson(Map<String, dynamic> json) {
  return AboutAppResultModel(
    settings: json['settings'] == null
        ? null
        : SettingsAppResultModel.fromJson(
            json['settings'] as Map<String, dynamic>),
    email: json['email'] as String?,
    phone: json['phone'] as String?,
    mobile: json['mobile'] as String?,
    address: json['address'] as String?,
    facebook: json['facebook'] as String?,
    instagram: json['instagram'] as String?,
    fax: json['fax'] as String?,
    twitter: json['twitter'] as String?,
    site_desc: json['site_desc'] as String?,
    site_name: json['site_name'] as String?,
    whatsapp: json['whatsapp'] as String?,
    videoHome: json['videoHome'] == null
        ? null
        : VideoHomeResultModel.fromJson(
            json['videoHome'] as Map<String, dynamic>),
    youtube: json['youtube'] as String?,
  );
}

Map<String, dynamic> _$AboutAppResultModelToJson(
        AboutAppResultModel instance) =>
    <String, dynamic>{
      'site_name': instance.site_name,
      'site_desc': instance.site_desc,
      'address': instance.address,
      'mobile': instance.mobile,
      'phone': instance.phone,
      'email': instance.email,
      'fax': instance.fax,
      'facebook': instance.facebook,
      'twitter': instance.twitter,
      'youtube': instance.youtube,
      'instagram': instance.instagram,
      'whatsapp': instance.whatsapp,
      'videoHome': instance.videoHome,
      'settings': instance.settings,
    };

VideoHomeResultModel _$VideoHomeResultModelFromJson(Map<String, dynamic> json) {
  return VideoHomeResultModel(
    title: json['title'] as String?,
    details: json['details'] as String?,
    link_url: json['link_url'] as String?,
    video_link: json['video_link'] as String?,
  );
}

Map<String, dynamic> _$VideoHomeResultModelToJson(
        VideoHomeResultModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'details': instance.details,
      'video_link': instance.video_link,
      'link_url': instance.link_url,
    };

SettingsAppResultModel _$SettingsAppResultModelFromJson(
    Map<String, dynamic> json) {
  return SettingsAppResultModel(
    currency_right: json['currency_right'] as String?,
    default_currency: json['default_currency'] as String?,
    default_tax: json['default_tax'] as String?,
    enable_paypal: json['enable_paypal'] as String?,
    enable_stripe: json['enable_stripe'] as String?,
    fee_delivery: json['fee_delivery'] as String?,
    google_maps_key: json['google_maps_key'] as String?,
  );
}

Map<String, dynamic> _$SettingsAppResultModelToJson(
        SettingsAppResultModel instance) =>
    <String, dynamic>{
      'enable_stripe': instance.enable_stripe,
      'default_tax': instance.default_tax,
      'default_currency': instance.default_currency,
      'enable_paypal': instance.enable_paypal,
      'google_maps_key': instance.google_maps_key,
      'fee_delivery': instance.fee_delivery,
      'currency_right': instance.currency_right,
    };
