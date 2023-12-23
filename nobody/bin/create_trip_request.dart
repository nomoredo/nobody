import 'package:nobody/lib.dart';

void main() async {
  await create_trip_request();
}

Future create_trip_request() async {
  var empno = "9711068";
  var kind = "Job Travel";
  var subject = "Test";
  var description = "Test";
  var start_date = "01.01.2024";
  var end_date = "01.01.2024";
  var country = "United Arab Emirates";
  var airport_city = "Dubai";

  Nobody()
      .online()
      .login(Sap.User('amohandas'))
      .visit(TripRequestOnBehalfOf)
      .list_inputs()
      .set(
          Input.WithId(
              "application-ZFOC_TRIP_FORM-display-component---object--Pernr-inner"),
          empno)
      .click(Button.WithId(
          "application-ZFOC_TRIP_FORM-display-component---object--gobtn"))
      // .list_forms()
      .set(
          Input.WithId(
              "application-ZFOC_TRIP_FORM-display-component---object--tripType-hiddenInput"),
          kind)
      .set(
          TextArea.WithId(
              "application-ZFOC_TRIP_FORM-display-component---object--sub-inner"),
          subject)
      .set(
          TextArea.WithId(
              "application-ZFOC_TRIP_FORM-display-component---object--desc-inner"),
          description)
      .set(
          Input.WithId(
              "application-ZFOC_TRIP_FORM-display-component---object--start-inner"),
          start_date)
      .set(
          Input.WithId(
              "application-ZFOC_TRIP_FORM-display-component---object--end-inner"),
          end_date)
      .set(
          Input.WithId(
              "application-ZFOC_TRIP_FORM-display-component---object--tripCntry-inner"),
          country)
      .set(
          Input.WithId(
              "application-ZFOC_TRIP_FORM-display-component---object--tripRsn-inner"),
          "simply for fun")
      .set(
          Input.WithId(
              "application-ZFOC_TRIP_FORM-display-component---object--loc-inner"),
          airport_city);
}

final TripRequestOnBehalfOf =
    "https://cbs.almansoori.biz/sap/bc/ui5_ui5/ui2/ushell/shells/abap/FioriLaunchpad.html?sap-client=800&sap-language=EN%23Shell-home&appState=lean#ZFOC_TRIP_FORM-display&/TripdetailsSet";
