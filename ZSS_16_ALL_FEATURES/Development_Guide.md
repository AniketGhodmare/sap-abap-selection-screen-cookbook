
---

## 📄 Development_Guide.md

```markdown
# Development Guide – ZSS_16_ALL_FEATURES

## Architecture Overview

The program is structured as a **main report** that includes ten separate include files. Each include file encapsulates a specific concern, making the code easy to navigate, maintain, and extend.

### Modularisation Benefits

- **Separation of Concerns** – Each tab’s selection screen and its logic reside in its own include.
- **Reusability** – Validation and utility routines are shared across tabs.
- **Parallel Development** – Different developers can work on different includes simultaneously.
- **Ease of Testing** – Isolated units can be tested independently.
- **Scalability** – New tabs or features can be added by creating new includes.

---

## File Descriptions

| Include File | Responsibility |
|--------------|----------------|
| `ZSS_16_TOP_INCLUDE` | Global data definitions: tables, types, global variables, constants. |
| `ZSS_16_TAB1_INCLUDE` | **General Tab** – defines screen 1001, its parameters and select‑options, plus tab‑specific events (`INITIALIZATION`, `AT SELECTION-SCREEN OUTPUT`, F4 help). |
| `ZSS_16_TAB2_INCLUDE` | **Selection Tab** – defines screen 1002, its select‑options, and associated events and F4 helps. |
| `ZSS_16_TAB3_INCLUDE` | **Upload Tab** – defines screen 1003, file/folder browsers, checkboxes, push buttons, and events. |
| `ZSS_16_TAB4_INCLUDE` | **Advanced Tab** – defines screen 1004, checkboxes, listbox, and performance parameters. |
| `ZSS_16_VALIDATION_INCLUDE` | All validation routines: employee, sales org, material, customer, plant, date, cross‑field, file, authorisation. |
| `ZSS_16_DYNAMIC_INCLUDE` | Centralised dynamic screen modifications using `LOOP AT SCREEN` and `MODIF ID`. |
| `ZSS_16_PROCESSING_INCLUDE` | Main processing logic: gathering selection summary, data retrieval, upload, parallel processing, logging, and output display. |
| `ZSS_16_UTILITY_INCLUDE` | Utility functions: reset all fields, preview, export, help, about. |
| `ZSS_16_EVENTS_INCLUDE` | **Main event handler** – contains all the ABAP selection‑screen events (e.g., `INITIALIZATION`, `AT SELECTION-SCREEN OUTPUT`, `AT SELECTION-SCREEN`, `START-OF-SELECTION`). It orchestrates calls to the other includes. |

---

## Data Flow

1. **User interacts with the selection screen** → triggers the relevant events.
2. **`INITIALIZATION`** sets default values.
3. **`AT SELECTION-SCREEN OUTPUT`** applies dynamic modifications (hiding, disabling, etc.) via `ZSS_16_DYNAMIC_INCLUDE`.
4. **Field‑specific validations** are triggered on each field change (e.g., `AT SELECTION-SCREEN ON p_emp`).
5. **Global validations** happen in `AT SELECTION-SCREEN` (date ranges, cross‑field checks).
6. **When the user clicks Execute**, `START-OF-SELECTION` calls `gather_selection_summary`, `validate_all`, and `main_processing`.
7. **`main_processing`**:
   - Reads data (simulated or from uploaded file).
   - Applies max records limit.
   - Handles logging and parallel processing flags.
8. **`END-OF-SELECTION`** calls `display_output`, which shows the summary and the ALV grid.

---

## Adding a New Tab

1. Create a new include file (e.g., `ZSS_16_TAB5_INCLUDE`).
2. Define a new subscreen (e.g., screen 1005) inside it.
3. Add the required parameters, select‑options, and event forms (`init_tab5`, `tab5_screen_output`, etc.).
4. In the main program, add the new tab to the tabbed block:
   ```abap
   SELECTION-SCREEN TAB (30) tab5 USER-COMMAND TAB5 DEFAULT SCREEN 005.
   ```
5. Include the new file in the main program after the other includes.
6. Extend the `INITIALIZATION` and `AT SELECTION-SCREEN OUTPUT` routines to call the new tab’s forms (already triggered via events, but you may need to call `init_tab5` in `INITIALIZATION`).
7. Add any necessary constants and update the global data if needed.

---

## Dynamic Screen Modification – How It Works

- Each field on the selection screen has a **MODIF ID** (e.g., `g01`, `s04`, `u03`, `a02`).
- In `ZSS_16_DYNAMIC_INCLUDE`, we loop over the internal table `SCREEN` and change its attributes (`input`, `active`, `required`, etc.) based on the `screen-group1` value.
- This is executed in `AT SELECTION-SCREEN OUTPUT`, so changes are applied before the screen is displayed.

**Example:**  
When `p_test` (test run) is checked, the upload buttons become inactive (`screen-input = 0`).

---

## Validation Strategy

- **Field‑level validations** are placed in `AT SELECTION-SCREEN ON <field>` events (e.g., `p_emp`).  
- **Block‑level validations** are in `AT SELECTION-SCREEN ON BLOCK <block>`.  
- **Global validations** (e.g., date from/to) are in `AT SELECTION-SCREEN`.  
- **Cross‑field validations** are in a separate routine `validate_cross_field` called from the main event.  
- All validation routines are collected in `ZSS_16_VALIDATION_INCLUDE` and can be triggered manually via the **Validate** button.

---

## Adding a New Validation

1. Open `ZSS_16_VALIDATION_INCLUDE`.
2. Create a new `FORM` (e.g., `validate_new_field`).
3. Add the logic (e.g., check if a field exists in a table).
4. Include the new validation in the master `validate_all` routine.
5. Optionally, trigger it on a specific field using `AT SELECTION-SCREEN ON <field>`.

---

## F4 Help and Search Help

- F4 help for parameters is implemented in the tab‑specific includes using:
  - `F4IF_FIELD_VALUE_REQUEST` for simple field checks.
  - `F4IF_INT_TABLE_VALUE_REQUEST` for value lists.
  - `CL_GUI_FRONTEND_SERVICES=>FILE_OPEN_DIALOG` and `DIRECTORY_BROWSE` for file/folder browsing.
- Search help for select‑options is attached via the `MATCHCODE OBJECT` in the data dictionary or by using `F4IF_INT_TABLE_VALUE_REQUEST` with the appropriate dynamic field name.

---

## Function Keys

The program defines three function keys (F1–F3) using `SELECTION-SCREEN FUNCTION KEY`. Their labels are set in `INITIALIZATION` via `sscrfields-functxt_01` … `03`.  
User commands `FC01`, `FC02`, `FC03` are handled in `handle_user_command` in `ZSS_16_EVENTS_INCLUDE`.

If you want to use a custom GUI status, create `SEL_STATUS` in SE41 with the same function codes.

---

## Output and ALV

The output is displayed in `END-OF-SELECTION`:
1. A **selection summary** is printed (using `WRITE` statements).
2. The data table `gt_out` is passed to `REUSE_ALV_GRID_DISPLAY` for a professional grid display.

To customise the ALV output, you can add field catalog, layouts, or use the class‑based ALV (`CL_SALV_TABLE`). The current approach uses the classic function module for simplicity and compatibility.

---

## Error Handling and Messages

- All messages use `MESSAGE … WITH` to provide dynamic text.
- The program uses message class `00` – you can change it by modifying the `REPORT` statement or assigning a custom message class.
- For informational popups, the utility include uses `POPUP_TO_INFORM`.

---

## Performance Considerations

- The report is designed as a demonstration; the data processing is simulated.
- For real‑world use, you would replace the dummy data retrieval with actual database selections, possibly using `FOR ALL ENTRIES` or joins.
- The **max records** limit prevents accidental overload.
- **Parallel processing** is simulated – you would need to implement a real parallel framework (e.g., using `SPBT_INIT` / `SPBT_RUN`) if required.

---

## Testing

- Run the report and test each tab individually.
- Use the **Validate** button to check all validations.
- Use **Test Run** to skip data processing and verify the selection summary.
- Upload a sample text file to test the upload functionality.

---

## Extending the Code

- **Add new fields**: Add them to the appropriate tab include, and update the global summary structure and validation logic.
- **New tabs**: Follow the pattern in `TAB1_INCLUDE` – create a new subscreen and include it in the main program.
- **New features**: You can add more push buttons, function keys, or additional processing steps.

---

## Troubleshooting

- **Inline declaration errors**: The code uses classic `DATA` declarations; if you see such errors, ensure you are using the corrected version provided.
- **GUI status missing**: If you get a runtime error about missing status `SEL_STATUS`, either create it in SE41 or comment out the `SET PF-STATUS` line.
- **F4 not working**: Check that the called function modules are available in your system.
- **ALV not showing**: Ensure the data table `gt_out` is populated; if not, check the processing logic.

---

## Conclusion

This modular design provides a solid foundation for building complex selection screens in ABAP. By following the same structure, you can easily adapt it to your own business requirements while maintaining clean, maintainable code.

---

**Happy Developing!**
```

---