@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Proiezione tabella Biglietto'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZBIGLIETTO_P_FDB
  provider contract transactional_query
  as projection on ZBIGLIETTO_R_FDB
{
  key Id_Biglietto,
      @Semantics.user.createdBy: true
      Creation_Da,
      @Semantics.systemDateTime.createdAt: true
      Creation_A,
      @Semantics.user.lastChangedBy: true
      Modificato_Da,
      @Semantics.systemDateTime.lastChangedAt: true
      Modificato_A

}
