@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root View per Biglietto'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZBIGLIETTO_R_FDB
  as select from zbiglietto_fdb as BIGLIETTO
  //composition of target_data_source_name as _association_name
{
  key BIGLIETTO.id_biglietto  as Id_Biglietto,
      BIGLIETTO.creation_da   as Creation_Da,
      BIGLIETTO.creation_a    as Creation_A,
      BIGLIETTO.modificato_da as Modificato_Da,
      BIGLIETTO.modificato_a  as Modificato_A
      //    _association_name // Make association public

      //{


}
