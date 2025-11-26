@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZBIGL_FDB_V2'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_BIGL_FDB_V2
  as select from ZBIGL_FDB_V2 as Biglietto
{
  key id_biglietto as IdBiglietto,
  @Semantics.user.createdBy: true
  creation_da as CreationDa,
  @Semantics.systemDateTime.createdAt: true
  creation_a as CreationA,
  @Semantics.user.lastChangedBy: true
  modificato_da as ModificatoDa,
  @Semantics.systemDateTime.lastChangedAt: true
  modificato_a as ModificatoA,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  locallastchange as Locallastchange
}
