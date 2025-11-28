@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZCOMP_NN_FDB'
}
@AccessControl.authorizationCheck: #MANDATORY
define view entity ZC_COMP_NN_FDB
  as projection on ZR_COMP_NN_FDB
  association [1..1] to ZR_COMP_NN_FDB as _BaseEntity on $projection.IdBiglietto = _BaseEntity.IdBiglietto and $projection.Progressivo = _BaseEntity.Progressivo
{
  key IdBiglietto,
  key Progressivo,
  TipoUtente,
  @Semantics: {
    user.createdBy: true
  }
  AbpCreationUser,
  @Semantics: {
    systemDateTime.createdAt: true
  }
  AbpCreationTstmpl,
  @Semantics: {
    user.lastChangedBy: true
  }
  AbpLastchangeUser,
  @Semantics: {
    systemDateTime.lastChangedAt: true
  }
  AbpLastchangeTstmpl,
  @Semantics: {
    systemDateTime.localInstanceLastChangedAt: true
  }
//  AbpLocinstLastchangeTstmpl,
  _BaseEntity,
  Biglietto : redirected to parent ZC_BIGL_FDB_V2
}
