// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_quality_assuarance_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddQualityAssuranceForm _$AddQualityAssuranceFormFromJson(
        Map<String, dynamic> json) =>
    AddQualityAssuranceForm(
      type: json['type'] as String?,
      name: json['name'] as String?,
      administratorId: json['administrator_id'] as int?,
      address: json['address'] as String?,
      telephone: json['telephone'] as String?,
      nameAddressOfOrigin: json['name_address_of_origin'] as String?,
      supplierName: json['supplier_name'] as String?,
      supplierAddress: json['supplier_address'] as String?,
      storeLocation: json['store_location'] as String?,
      quantiryOfSeed: json['quantiry_of_seed'] as String?,
      istaCertificate: json['ista_certificate'] as String?,
      inspectorId: json['inspector_id'] as int?,
      nationalSeedBoardRegNum: json['national_seed_board_reg_num'] as String?,
      isImport: json['is_import'] as bool?,
      permitNumber: json['permit_number'] as String?,
      status: json['status'] as String?,
      statusComment: json['status_comment'] as String?,
      validFrom: json['valid_from'] as String?,
      validUntil: json['valid_until'] as String?,
      additionalConditions: json['additional_conditions'] as String?,
      cropVarieties: (json['import_export_permits_has_crops'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$AddQualityAssuranceFormToJson(
        AddQualityAssuranceForm instance) =>
    <String, dynamic>{
      'administrator_id': instance.administratorId,
      'type': instance.type,
      'name': instance.name,
      'address': instance.address,
      'telephone': instance.telephone,
      'store_location': instance.storeLocation,
      'quantiry_of_seed': instance.quantiryOfSeed,
      'name_address_of_origin': instance.nameAddressOfOrigin,
      'supplier_name': instance.supplierName,
      'supplier_address': instance.supplierAddress,
      'ista_certificate': instance.istaCertificate,
      'inspector_id': instance.inspectorId,
      'national_seed_board_reg_num': instance.nationalSeedBoardRegNum,
      'is_import': instance.isImport,
      'permit_number': instance.permitNumber,
      'status': instance.status,
      'status_comment': instance.statusComment,
      'valid_from': instance.validFrom,
      'valid_until': instance.validUntil,
      'additional_conditions': instance.additionalConditions,
      'import_export_permits_has_crops': instance.cropVarieties,
    };
