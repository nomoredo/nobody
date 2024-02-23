import 'package:nobody/references.dart';

void main(List<String> arguments) async {
  await export_emp_attendance();
}

Future export_emp_attendance() async {
  return create_pr();
}

final SapTransaction create_service_pr = SapTransaction.builder()
    .prepare((x) =>
        x.login(Sap.User('amohandas')).goto(SapPurchaseRequestUrl("ZPRS")))
    .with_textbox("header", lsdata: "cntlTEXT_EDITOR_0101/shellcont/shell")
    .maybe_click("maybe expand section",
        css: 'div[role="button"][title="Expand Items Ctrl+F3"]')
    .many("lineItems", (SapTransaction n) {
  return n
      .grid_cell("account_assignment", lsdata: "rowcol/row[1]/cell[1]")
      .grid_cell("description", lsdata: "rowcol/row[1]/cell[4")
      .grid_cell("expense_type", lsdata: "rowcol/row[1]/cell[2]")
      .grid_cell("quantity", lsdata: "rowcol/row[1]/cell[5]")
      .grid_cell("unit", lsdata: "rowcol/row[1]/cell[6]")
      .grid_cell("material_type", lsdata: "rowcol/row[1]/cell[9]")
      .grid_cell("price", lsdata: "rowcol/row[1]/cell[10]")
      .grid_cell("currency", lsdata: "rowcol/row[1]/cell[11]")
      .grid_cell("tracking", lsdata: "rowcol/row[1]/cell[12]")
      .many("serviceItems", (SapTransaction m) {
    return m
        // .prepare((x) => x.press(Key.enter))
        .grid_cell("serviceCode", lsdata: "ctxtESLL-SRVPOS[2,0]")
        .grid_cell("description", lsdata: "txtESLL-KTEXT1[3,0]")
        .grid_cell("quantity", lsdata: "txtESLL-MENGE[4,0]")
        .grid_cell("unit", lsdata: "ctxtESLL-MEINS[5,0]")
        .grid_cell("wbs", lsdata: "ctxtRM11P-PS_PSP_PNR[6,0]")
        .grid_cell("price", lsdata: "txtESLL-TBTWR[7,0]");
  }, before: (x) => x.press(Key.enter));
}).validate((browser) async {
  final title = await browser
      .click(Sap.Button("Check (Ctrl+Shift+F3)"))
      .wait(Waitable.Seconds(2))
      .get_element(WithId('wnd[0]/sbar_msg-txt'))
      .get_value()
      .map((x) =>
          ValidationResponse.ShouldMatch(x, "No messages issued during check"));

  return title;
}).submit((x) async {
  final should_submit =
      await Ask.input("Do you want to submit the PR?", "yes/no");
  if (should_submit == "yes") {
    final prnumber = await x
        .click(Sap.Button("Save (Ctrl+S)"))
        .wait(Waitable.Seconds(2))
        .get_element(WithId('wnd[0]/sbar_msg-txt'))
        .get_value();
    Show.action("PR Created", prnumber ?? "No PR number found");
  }
  return x;
});

Future create_pr() async {
  // SapTransaction create_service_pr = SapTransaction.builder()
  //     .prepare((x) =>
  //         x.login(Sap.User('amohandas')).goto(SapPurchaseRequestUrl("ZPRS")))
  //     .with_textbox("header", lsdata: "cntlTEXT_EDITOR_0101/shellcont/shell")
  //     .maybe_click("maybe expand section",
  //         css: 'div[role="button"][title="Expand Items Ctrl+F3"]')
  //     .many("lineItems", (SapTransaction n) {
  //   return n
  //       .grid_cell("account_assignment", lsdata: "rowcol/row[1]/cell[1]")
  //       .grid_cell("description", lsdata: "rowcol/row[1]/cell[4")
  //       .grid_cell("expense_type", lsdata: "rowcol/row[1]/cell[2]")
  //       .grid_cell("quantity", lsdata: "rowcol/row[1]/cell[5]")
  //       .grid_cell("unit", lsdata: "rowcol/row[1]/cell[6]")
  //       .grid_cell("material_type", lsdata: "rowcol/row[1]/cell[9]")
  //       .grid_cell("price", lsdata: "rowcol/row[1]/cell[10]")
  //       .grid_cell("currency", lsdata: "rowcol/row[1]/cell[11]")
  //       .grid_cell("tracking", lsdata: "rowcol/row[1]/cell[12]")
  //       .many("serviceItems", (SapTransaction m) {
  //     return m
  //         // .prepare((x) => x.press(Key.enter))
  //         .grid_cell("serviceCode", lsdata: "ctxtESLL-SRVPOS[2,0]")
  //         .grid_cell("description", lsdata: "txtESLL-KTEXT1[3,0]")
  //         .grid_cell("quantity", lsdata: "txtESLL-MENGE[4,0]")
  //         .grid_cell("unit", lsdata: "ctxtESLL-MEINS[5,0]")
  //         .grid_cell("wbs", lsdata: "ctxtRM11P-PS_PSP_PNR[6,0]")
  //         .grid_cell("price", lsdata: "txtESLL-TBTWR[7,0]");
  //   }, before: (x) => x.press(Key.enter));
  // }).validate((browser) async {
  //   final title = await browser
  //       .click(Sap.Button("Check (Ctrl+Shift+F3)"))
  //       .wait(Waitable.Seconds(2))
  //       .get_element(WithId('wnd[0]/sbar_msg-txt'))
  //       .get_value()
  //       .map((x) => ValidationResponse.ShouldMatch(
  //           x, "No messages issued during check"));

  //   return title;
  // }).submit((x) async {
  //   final should_submit =
  //       await Ask.input("Do you want to submit the PR?", "yes/no");
  //   if (should_submit == "yes") {
  //     final prnumber = await x
  //         .click(Sap.Button("Save (Ctrl+S)"))
  //         .wait(Waitable.Seconds(2))
  //         .get_element(WithId('wnd[0]/sbar_msg-txt'))
  //         .get_value();
  //     Show.action("PR Created", prnumber ?? "No PR number found");
  //   }

  //   return x;
  // });

  // var browser = await Nobody().online();

  /// 0	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21
  /// DATE	"REQUESTED BY"	"REQUESTED FOR"	"PR TYPE"	"PR NUMBER"	"PR ITEM"	ACC	EXT	DESCRIPTION	QTY	UNIT	PRICE	CURRENCY	TRACKING	TYPE	"SERVICE CODE"	"SERVICE DESCRIPTION"	SQTY	SUNIT	SPRICE	SCUR	WBS

  final excel_file = await nobody
      .open(ExcelFile(r"C:\repo\nobody\nobody\PURCHASE REQUESTS.xlsx"))
      .sheet("REQUESTS")
      .rows((r) => r[5].is_empty && r[10].is_not_empty)
      .map((r) => {
            "header": "AS REQUESTED BY ${r[1]} FOR ${r[2]}",
            "lineItems": [
              {
                "account_assignment": r[6],
                "expense_type": r[7],
                "description": r[8],
                "quantity": r[9],
                "unit": r[10],
                "price": r[11],
                "currency": r[12],
                "tracking": r[13],
                "material_type": r[14],
                "serviceItems": [
                  {
                    "serviceCode": r[15],
                    "description": r[16],
                    "quantity": r[17],
                    "unit": r[18],
                    "price": r[19],
                    "currency": r[20],
                    "wbs": r[21],
                  }
                ]
              }
            ]
          });

  Show.tree(excel_file);
  for (var pr in excel_file) {
    await create_service_pr.fill(pr);
  }

  // await create_service_pr.fill(browser, {
  //   "header":
  //       "AS REQUESTED BY X FOR Y PROJECT", // always starts with AS REQUESTED BY (name) FOR (project name)
  //   // header can be up to 500 characters and usually contains full details of the request like complete scope of work
  //   // or any other details that cannot be captured in line items due to character limit
  //   "lineItems": [
  //     {
  //       "account_assignment": "P", // always P
  //       "expense_type": "D", // always D
  //       "description":
  //           "TEST SERVICE DESCRIPTION", // description should be less than 40 characters
  //       "quantity": 1,
  //       "unit": "EA",
  //       "price": 0.01,
  //       "currency": "AED",
  //       "tracking":
  //           "trking", // referece to quote number or any other reference less than or equal to 7 characters
  //       "material_type": "SERVICE", // always SERVICE
  //       "serviceItems": [
  //         {
  //           "serviceCode":
  //               "1000000438", // service code (refer service master data for the correct code)
  //           "description":
  //               "TEST DESCRIPTION", // auto populated from service code
  //           "quantity": "1", // quantity of service line item
  //           "unit": "EA",
  //           "price": "0.01", // always 0.01
  //           "currency": "AED", // based on quote if any or AED
  //           "wbs":
  //               "MWS-AE-0017.01.001", // WBS element (refer WBS master data for the correct code)
  //         }
  //       ]
  //     }
  //   ]
  // });
}


/// ----------------- SYSTEM PROMPT -----------------
/// Generate purchase request as per [REQUEST FORMAT] following the
/// [GENERAL GUIDELINES] and using the [WBS Master Data] and [Service Master Data]
/// for the provided requirement. if any attachments are provided by the user,
/// use the information from the attachments to fill the purchase request.
/// if any information is not readily available, please ask for the information before generating the purchase request.


/// ----------------- GENERAL GUIDELINES -----------------
/// 1. All requests should be in the above format
/// 2. Header should always start with "AS REQUESTED BY" followed by the name of the requester and the project name
/// 3. Header can be up to 500 characters and usually contains full details of the request like complete scope of work
///   or any other details that cannot be captured in line items due to character limit. header can include references
///   to quotes, name of the supplier (if quote is provided), etc.
/// 4. Description should be less than 40 characters
/// 5. Quantity should be 1 for all service line items
/// 6. Price should be 0.01 for all service line items
/// 7. Currency should be AED for all service line items unless otherwise specified in the quote
/// 8. Tracking should be a reference to quote number or any other reference less than or equal to 7 characters
/// 9. Material type should always be SERVICE for all service line items
/// 10. WBS element should be selected from the WBS master data (refer WBS master data for the correct code)
/// 11. Service code should be selected from the Service master data (refer service master data for the correct code)
/// 12. All requests should be submitted with the correct WBS element and service code
/// 14. If any information is not readily available, please ask for the information before submitting the request
/// 16. Try to keep the number of line items to a minimum and combine similar services into a single line item
/// 17. Try to include any Equipment numbers in the PR line item description as it is searchable in SAP


/// ----------------- REQUEST FORMAT -----------------
/// ALL REQUESTS SHOULD BE IN THE FOLLOWING FORMAT
/// {
///  "header": "AS REQUESTED BY X FOR Y PROJECT", // always starts with AS REQUESTED BY (name) FOR (project name)
/// // header can be up to 500 characters and usually contains full details of the request like complete scope of work
/// // or any other details that cannot be captured in line items due to character limit
/// "lineItems": [ // each request line item should be in the following format
///  {
/// "account_assignment": "P", // always P
/// "expense_type": "D", // always D
/// "description": "TEST SERVICE DESCRIPTION", // description should be less than 40 characters
/// "quantity": 1,
/// "unit": "EA",
/// "price": 0.01,
/// "currency": "AED",
/// "tracking": "trking", // referece to quote number or any other reference less than or equal to 7 characters
/// "material_type": "SERVICE", // always SERVICE
/// "serviceItems": [ // each service line item should be in the following format
/// {
/// "serviceCode": "1000000438", // service code (refer service master data for the correct code)
/// "description": "TEST DESCRIPTION", // auto populated from service code
/// "quantity": "1", // quantity of service line item
/// "unit": "EA",
/// "price": "0.01", // always 0.01
/// "currency": "AED", // based on quote if any or AED
/// "wbs": "MWS-AE-0017.01.001", // WBS element (refer WBS master data for the correct code)
/// }
/// ]
/// }
/// ]
/// }



/// ----------------- WBS Master Data -----------------
/// WBS Element          Description
/// MWS-AE-0017.01       MWS ADNOC ONSHORE
/// MWS-AE-0017.01.001   MWS ADNOC ONSHORE BAB
/// MWS-AE-0017.01.002   MWS ADNOC ONSHORE NEB
/// MWS-AE-0017.01.003   MWS ADNOC ONSHORE BUHASA
/// MWS-AE-0017.01.004   MWS ADNOC ONSHORE ASAB
/// MWS-AE-0020.01       MWS ADNOC OFFSHORE
/// MWS-AE-0020.01.001   MWS ADNOC OFFSHORE ISLAND
/// MWS-AE-0020.01.002   MWS ADNOC OFFSHORE SATAH
/// MWS-AE-0020.01.003   MWS ADNOC OFFSHORE UMM LULU
/// MWS-AE-0020.01.004   MWS ADNOC OFFSHORE UMM DALKH

/// ----------------- Service Master Data -----------------
/// Activity    Service Short Text
/// 1000000438  MWS INSPECTION SERVICES 20%(TUV)             
/// 1000001652  MWS LOAD TEST & VISUAL INSPECTION            
/// 1000001653  MWS MPI / UT / DPI INSPECTION                
/// 1000001654  MWS HYDRO TESTING INSPECTION                 
/// 1000001655  MWS ZONE 2 CERTIFICATION                     
/// 1000001656  MWS HOSE REPAIR FOR UNIT                     
/// 1000001657  MWS HOSE REPAIR FOR PCE                      
/// 1000001658  MWS AIR CONDITIONER SERVICING UNIT           
/// 1000001659  MWS AIR CONDITIONER SERVICING BUILDING       
/// 1000001660  MWS CALIBRATION OF GAUGES                    
/// 1000001661  MWS RADIATOR MAINTENANCE                     
/// 1000001662  MWS REPAIR OF PCE                            
/// 1000001663  MWS REPAIR OF WINCH UNIT                     
/// 1000001664  MWS REPAIR OF POWER PACK                     
/// 1000001665  MWS REPAIR OF GENERAL CONTAINERS             
/// 1000001666  MWS REPAIR OF DOWN HOLE TOOLS                
/// 1000001667  MWS TESTING OIL                              
/// 1000001668  MWS TRANSPORTATION LOCAL                     
/// 1000001669  MWS COURSES AND TRAININGS                    
/// 1000001670  MWS PAINTING AND SANDBLASTING                
/// 1000001671  MWS SERVICE OF IVMS                          
/// 1000001672  MWS SERVICE OF FIRE EXTINGUISHER             
/// 1000001673  MWS SERVICE OF VEHICLE                       
/// 1000001674  MWS RENTAL OF DOWN HOLE TOOLS                
/// 1000001675  MWS OVERHAULING ENGINE                       
/// 1000001676  MWS REPAIR OF MEMORY GAUGE                   
/// 1000001677  MWS REPAIR OF LOGGING TOOL                   
/// 1000001678  MWS REPAIR OF BHS TOOL                       
/// 1000001679  MWS REPAIR OF DOWN HOLE ACCESSORIES          
/// 1000001680  MWS PASSTHROUGH EXPENSES                     
/// 1000001681  MWS REPAIR OF SAFETY GEARS                   
/// 1000001682  MWS RENTAL OF SAFETY GEARS                   
/// 1000001683  MWS RENTAL OF VEHICLES                       
/// 1000001684  MWS ELECTRICAL SERVICES BUILDING             
/// 1000001685  MWS CERTIFICATION EXPENSES                   
/// 1000001686  MWS REPAIR OF COMPRESSOR                     
/// 1000001687  MWS REPAIR OF PRINTER                        
/// 1000001688  MWS CONSULTATION SERVICES                    
/// 1000001689  MWS INSTALLATION OF SAFETY GEAR              
/// 1000001690  MWS BUILDING MAINTENANCE                     
/// 1000001691  MWS SPOOLING SERVICE                         
/// 1000001692  MWS RENTAL OF MANPOWER                       
/// 1000001693  MWS CATERING SERVICES                        
/// 1000001694  MWS ACCOMMODATION SERVICES                   
/// 1000001695  MWS PRINTING AND STATIONARY                  
/// 1000001696  MWS LAUNDRY SERVICE                          
/// 1000001697  MWS RENTAL OF GENERAL EQUIPMENT              
/// 1000002056  MWS RENTAL OF WORKSHOP                   


/// ----------------- LEGEND -----------------
/// PCE - Pressure Control Equipment
/// IVMS - In Vehicle Monitoring System
/// BHS - Bottom Hole Assembly
/// DPI - Dye Penetrant Inspection
/// UT - Ultrasonic Testing
/// MPI - Magnetic Particle Inspection
/// TUV - Technical Inspection Association
/// WBS - Work Breakdown Structure
/// PASS THROUGH EXPENSES - Expenses that are passed through to the client (will be specifically mentioned by the requester)
