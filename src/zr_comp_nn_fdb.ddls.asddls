@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZCOMP_NN_FDB'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define view entity ZR_COMP_NN_FDB
  as select from zcomp_nn_fdb
  association to parent ZR_BIGL_FDB_V2 as Biglietto
  on Biglietto.IdBiglietto =$projection.IdBiglietto
{
  key id_biglietto as IdBiglietto,
  key progressivo as Progressivo,
  tipo_utente as TipoUtente,
  @Semantics.user.createdBy: true
  abp_creation_user as AbpCreationUser,
  @Semantics.systemDateTime.createdAt: true
  abp_creation_tstmpl as AbpCreationTstmpl,
  @Semantics.user.lastChangedBy: true
  abp_lastchange_user as AbpLastchangeUser,
  @Semantics.systemDateTime.lastChangedAt: true
  abp_lastchange_tstmpl as AbpLastchangeTstmpl,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  //abp_locinst_lastchange_tstmpl as AbpLocinstLastchangeTstmpl,
  Biglietto
}
