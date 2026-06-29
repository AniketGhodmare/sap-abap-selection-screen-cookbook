# ZSS_15_ALL_FEATURES – Sales Order Report

## Overview

**ZSS_16_ALL_FEATURES** is a comprehensive ABAP report that demonstrates **all important selection‑screen features** used in real‑world SAP projects. It implements a **Sales Order Report** with a tabbed interface, parameter and select‑option fields, checkboxes, radio buttons, push buttons, function keys, F4 help, file/folder browsing, dynamic screen modification, validation, and a professional output.

This project is built following **SAP best practices** and is **modularised** into separate include files for easy maintenance and extension.

---

## Key Features

- ✅ **Tabbed Screen** with 4 tabs: General, Selection, Upload, Advanced  
- ✅ **Parameters** (single values) and **Select‑Options** (ranges)  
- ✅ **Checkboxes** and **Radio Buttons**  
- ✅ **Listbox** (application server selection)  
- ✅ **Push Buttons** for Validate, Reset, Preview, Execute, Export, Exit  
- ✅ **Function Keys** (F1 Help, F2 Reset, F3 About)  
- ✅ **F4 Help** (value requests) and **Search Help**  
- ✅ **File Browser** and **Folder Browser**  
- ✅ **Dynamic Screen Modification** (hide, disable, mandatory, invisible)  
- ✅ **Comprehensive Validation** (employee, sales org, material, customer, plant, cross‑field, file existence, authorisation)  
- ✅ **All Selection Screen Events** (`INITIALIZATION`, `AT SELECTION-SCREEN OUTPUT`, `AT SELECTION-SCREEN`, `AT SELECTION-SCREEN ON FIELD`, `ON BLOCK`, `ON RADIOBUTTON GROUP`, `ON VALUE REQUEST`, `ON HELP REQUEST`, `START-OF-SELECTION`, `END-OF-SELECTION`)  
- ✅ **Report Output** with selection summary and ALV grid  
- ✅ **Modular Code** – split into logical include files for clarity

---

## Business Scenario

The program simulates a **Sales Order Report**. Users can:

- Select basic parameters (employee, sales organisation, distribution channel, division).  
- Choose a date range and whether to report by order date or delivery date.  
- Select materials, customers, plants, storage locations, and sales orders.  
- Upload a file (e.g., a list of orders) and test‑run the process.  
- Control advanced settings like logging, parallel processing, server selection, and maximum records.

---

## Technical Details

- **ABAP Release:** Compatible with SAP NetWeaver 7.00 and above (uses classic `DATA` declarations – no inline declarations).  
- **Transaction:** The report can be executed via `SE38` or as a transaction.  
- **GUI Status:** Optional – the report uses `SET PF-STATUS 'SEL_STATUS'`; if the status does not exist, comment out that line – the standard toolbar will suffice.  
- **Message Class:** Uses message class `00` (can be changed).  

---

## Installation / Setup

1. **Create the Include Files**  
   Use transaction `SE38` to create the following includes in the same development package:

   - `ZSS_15_TOP_INCLUDE`  
   - `ZSS_15_TAB1_INCLUDE`  
   - `ZSS_15_TAB2_INCLUDE`  
   - `ZSS_15_TAB3_INCLUDE`  
   - `ZSS_15_TAB4_INCLUDE`  
   - `ZSS_15_VALIDATION_INCLUDE`  
   - `ZSS_15_DYNAMIC_INCLUDE`  
   - `ZSS_15_PROCESSING_INCLUDE`  
   - `ZSS_15_UTILITY_INCLUDE`  
   - `ZSS_15_EVENTS_INCLUDE`

2. **Create the Main Report**  
   Create the program `ZSS_15_ALL_FEATURES` and copy the main code (which includes all the above includes).

3. **Activate All Objects**  
   Activate the includes and the main program.

4. **Add Text Elements** (optional but recommended)  
   In the main program, go to **Goto → Text Elements → Selection Texts** and define the text symbols listed in the code comments.

5. **Optional GUI Status**  
   If you want the function keys (F1–F3) to work with custom labels, create a GUI status `SEL_STATUS` in transaction `SE41`. Otherwise, the standard function keys will still work with default labels.

6. **Run the Report**  
   Execute the main program (`SE38` → `ZSS_15_ALL_FEATURES`). The selection screen will appear with all tabs and features.

---

## How to Use the Selection Screen

- **General Tab** – Enter employee, sales organisation, distribution channel, division, date range, and choose between order date / delivery date.
- **Selection Tab** – Use select‑options to filter by material, customer, plant, storage location, and sales order. Click the search help icons (or press F4) for assistance.
- **Upload Tab** – Browse for a file or folder, enable/disable test run, and validate/upload.
- **Advanced Tab** – Toggle logging, parallel processing, choose a server (listbox), set maximum records, and adjust performance settings.

**Buttons at the bottom:**
- **Validate** – runs all validations.
- **Reset** – clears all fields and resets to defaults.
- **Preview** – shows a summary of your current selections.
- **Execute** – runs the report.
- **Export** – exports the result data to a file.
- **Exit** – leaves the report.

**Function Keys:**
- **F1** – context‑sensitive help (custom).  
- **F2** – reset all fields.  
- **F3** – about box.

---

## Project Structure
ZSS_16_ALL_FEATURES/
├── Main Program/
│ └── ZSS_16_ALL_FEATURES.abap
├── Includes/
│ ├── ZSS_16_TOP_INCLUDE.abap (Global data)
│ ├── ZSS_16_TAB1_INCLUDE.abap (General tab – screen 1001)
│ ├── ZSS_16_TAB2_INCLUDE.abap (Selection tab – screen 1002)
│ ├── ZSS_16_TAB3_INCLUDE.abap (Upload tab – screen 1003)
│ ├── ZSS_16_TAB4_INCLUDE.abap (Advanced tab – screen 1004)
│ ├── ZSS_16_VALIDATION_INCLUDE.abap (All validation routines)
│ ├── ZSS_16_DYNAMIC_INCLUDE.abap (Dynamic screen modification)
│ ├── ZSS_16_PROCESSING_INCLUDE.abap (Main processing & output)
│ ├── ZSS_16_UTILITY_INCLUDE.abap (Utility functions – reset, preview, export, help, about)
│ └── ZSS_16_EVENTS_INCLUDE.abap (Main event handlers)
└── Documentation/
├── README.md
└── Development_Guide.md

---

## Compatibility Notes

- The code uses **classic ABAP** (no inline declarations) to ensure compatibility with older SAP releases.
- All selection‑screen parameter names are **8 characters or fewer** (SAP naming rule).
- The report uses standard SAP function modules and classes (`CL_GUI_FRONTEND_SERVICES`, `REUSE_ALV_GRID_DISPLAY`, `GUI_UPLOAD`, etc.) – ensure your system supports them (they are available in most SAP GUI environments).

---

## Contributing

Feel free to extend the report with additional tabs, fields, or validations.  
Follow the modular pattern: create new includes for new tabs or functionalities, and include them in the main program.

---

## License

This project is provided as‑is for educational and demonstrative purposes. You may use and modify it freely.

---

## Contact

For questions or suggestions, please contact the development team.

---

**Happy ABAPing!**