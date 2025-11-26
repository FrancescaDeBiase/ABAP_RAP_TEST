@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Proiezione tabella Biglietto'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZBIGLIETTO_P_FDB
  provider contract transactional_query as projection on ZBIGLIETTO_R_FDB
  { 
 key Id_Biglietto,
    @Semantics.user.lastChangedBy: true
    Creation_Da,
    Creation_A,
    Modificato_Da,
    Modificato_A
   
}
