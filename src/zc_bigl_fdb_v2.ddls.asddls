@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZBIGL_FDB_V2'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_BIGL_FDB_V2
  provider contract transactional_query
  as projection on ZR_BIGL_FDB_V2
  association [1..1] to ZR_BIGL_FDB_V2 as _BaseEntity on $projection.IdBiglietto = _BaseEntity.IdBiglietto
{
  key IdBiglietto,
      @Semantics: {
        user.createdBy: true
      }
      CreationDa,
      @Semantics: {
        systemDateTime.createdAt: true
      }
      CreationA,
      @Semantics: {
        user.lastChangedBy: true
      }
      ModificatoDa,
      @Semantics: {
        systemDateTime.lastChangedAt: true
      }
      ModificatoA,
      @Semantics: {
        systemDateTime.localInstanceLastChangedAt: true
      }
      Locallastchange,
      stato,
      _BaseEntity,
      Componenti :  redirected to composition child ZC_COMP_NN_FDB
}
