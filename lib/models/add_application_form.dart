import 'package:json_annotation/json_annotation.dart';
part 'add_application_form.g.dart';

@JsonSerializable()
class AddApplicationForm {
  @JsonKey(name: 'administrator_id')
  int? administratorId;
  String? type;
  @JsonKey(name: 'name_of_applicant')
  String? nameOfApplicant;
  @JsonKey(name: 'company_initials')
  String? companyInitials;
  @JsonKey(name: 'phone_number')
  String? phoneNumber;
  String? address;
  @JsonKey(name: 'premises_location')
  String? premisesLocation;
  @JsonKey(name: 'years_of_expirience')
  //TODO backend make field same spelling
  int? yearsOfExpirience;
  @JsonKey(name: 'years_of_experience')
  int? yearsOfExperience;
  @JsonKey(name: 'seed_grower_in_past')
  String? seedGrowerInPast;
  @JsonKey(name: 'repackage_equipment')
  String? repackageEquipment;
  @JsonKey(name: 'expirience_in')
  String? expirienceIn;
  @JsonKey(name: 'dealers_in')
  String? dealersIn;
  @JsonKey(name: 'marketing_of')
  String? marketingOf;
  @JsonKey(name: 'isolation_distance')
  int? isolationDistance;
  @JsonKey(name: 'have_adequate_land')
  String? haveAdequateLand;
  @JsonKey(name: 'have_adequate_isolation')
  String? haveAdequateIsolation;
  @JsonKey(name: 'have_adequate_storage')
  String? haveAdequateStorage;
  @JsonKey(name: 'have_adequate_equipment')
  String? haveAdequateEquipment;
  @JsonKey(name: 'have_contractual_agreement')
  String? haveContractualAgreement;
  @JsonKey(name: 'have_adequate_field_officers')
  String? haveAdequateFieldOfficers;
  @JsonKey(name: 'have_conversant_seed_matters')
  String? haveConversantSeedMatters;
  @JsonKey(name: 'souce_of_seed')
  String? souceOfSeed;
  @JsonKey(name: 'have_adequate_land_for_production')
  String? haveAdequateLandForProduction;
  @JsonKey(name: 'have_internal_quality_program')
  String? haveInternalQualityProgram;
  // String receipt;
  @JsonKey(name: 'accept_declaration')
  String? acceptDeclaration;
  @JsonKey(name: 'cropping_histroy')
  String? croppingHistroy;
  //TODO fix naming issues
  @JsonKey(name: 'cropping_history')
  String? croppingHistory;
  @JsonKey(name: 'have_adequate_labor')
  String? haveAdequateLabor;
  @JsonKey(name: 'aware_of_minimum_standards')
  String? awareOfMinimumStandards;
  @JsonKey(name: 'signature_of_applicant')
  dynamic signatureOfApplicant;
  int? status;
  @JsonKey(name: 'valid_until')
  String? validUntil;
  @JsonKey(name: 'have_adequate_storage_facility')
  String? haveAdequateStorageFacility;
  @JsonKey(name: 'valid_from')
  String? validFrom;
  @JsonKey(name: 'previous_grower_number')
  String? previousGrowerNumber;
  @JsonKey(name: 'farm_location')
  String? farmLocation;
  @JsonKey(name: 'have_been_qds')
  int? haveBeenQds;
  @JsonKey(name: 'number_of_labors')
  int? numberOfLabors;

  AddApplicationForm({
    this.haveBeenQds,
    this.numberOfLabors,
    this.administratorId,
    this.address,
    this.type,
    this.phoneNumber,
    this.repackageEquipment,
    this.nameOfApplicant,
    this.companyInitials,
    this.premisesLocation,
    this.expirienceIn,
    this.yearsOfExpirience,
    this.dealersIn,
    this.marketingOf,
    this.haveAdequateLand,
    this.haveAdequateStorage,
    this.haveAdequateEquipment,
    this.haveAdequateFieldOfficers,
    this.haveAdequateLandForProduction,
    this.haveContractualAgreement,
    this.haveConversantSeedMatters,
    this.haveInternalQualityProgram,
    this.haveAdequateStorageFacility,
    this.acceptDeclaration,
    this.status,
    this.validFrom,
    this.validUntil,
    this.souceOfSeed,
    this.seedGrowerInPast,
    this.haveAdequateIsolation,
    this.croppingHistroy,
    this.haveAdequateLabor,
    this.awareOfMinimumStandards,
    this.signatureOfApplicant,
    this.previousGrowerNumber,
    this.isolationDistance,
    this.yearsOfExperience,
    this.croppingHistory,
    this.farmLocation,
  });
  Map toJson() {
    return _$AddApplicationFormToJson(this);
  }

  factory AddApplicationForm.fromJson(Map<String, dynamic> json) {
    return _$AddApplicationFormFromJson(json);
  }
}
