import 'package:nobody/lib.dart';
import 'package:nobody/references.dart';

void main(List<String> arguments) async {
  return create_emr_from_list();
}

final SapTransaction create_emr = SapTransaction.builder()
    .prepare(
        (x) => x.login(Sap.User('amohandas')).goto(SapTransactionUrl("IW21")))
    .textbox("emr_type", lsdata: "ctxtRIWO00-QMART")
    .press_key("start_creating_emr", Key.enter)
    .textbox("description", lsdata: "txtRIWO00-HEADKTXT")
    .textbox("from_date", lsdata: "ctxtVIQMEL-STRMN")
    .textbox("to_date", lsdata: "ctxtVIQMEL-LTRMN")
    .textbox("from_type", lsdata: "cmbZCBS_ETM_EMR_H-SENDER_TYPE")
    .textbox("from_location", lsdata: "ctxtZCBS_ETM_EMR_H-REFERENCE_S")
    .textbox("to_type", lsdata: "cmbZCBS_ETM_EMR_H-RECEIVER_TYP")
    .textbox("to_location", lsdata: "ctxtZCBS_ETM_EMR_H-REFERENCE_R")
    .press_key("start_equipment_selection", Key.enter)
    .maybe_click("select_equipment", lsdata: "TAB19")
    .many("equipments",
        (x) => x.grid_cell("equipment_id", lsdata: "row[1]/cell[0]")
        // .grid_cell("equipment_remarks", lsdata: "row[1]/cell[5]")
        )
    .press_key("save", Key.f1, modifiers: [Key.shift]).press_key(
        "complete", Key.f4,
        modifiers: [Key.shift]).press_key("complete_confirmation", Key.enter);

Future create_emr_from_list() async {
  final excel_file = await nobody
      .open(ExcelFile(r"C:\repo\nobody\nobody\EMR.xlsx"))
      .sheet("EMRS")
      .rows((r) => r[0].is_not_empty && r[2].is_not_empty && r[10].is_empty)
      .skip(1) //skip header
      .map((r) => {
            "emr_type": r[0],
            "description": r[1],
            "from_date": r[2],
            "from_type": r[3],
            "from_location": r[4],
            "to_date": r[5],
            "to_type": r[6],
            "to_location": r[7],
            "equipments": [
              {"equipment_id": r[8], "equipment_remarks": r[9]},
            ]
          });

  Show.tree(excel_file);
  for (var pr in excel_file) {
    await create_emr.fill(pr);
  }
}
