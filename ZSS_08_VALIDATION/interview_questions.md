# Interview Questions - ZSS_08_VALIDATION

This document contains frequently asked SAP ABAP interview questions related to **Selection Screen Validation**, **AT SELECTION-SCREEN Events**, and **User Input Validation**. The questions are categorized from beginner to advanced level, including real-time scenarios and tricky interview questions commonly asked in SAP ABAP interviews.

---

# Beginner Level

## 1. What is Selection Screen Validation in SAP ABAP?

**Answer:**

Selection Screen Validation is the process of checking user input before the report is executed to ensure the entered data is correct, complete, and follows business rules.

---

## 2. Why do we perform validation on the Selection Screen?

**Answer:**

Validation is performed to:

* Prevent invalid input
* Improve data quality
* Reduce runtime errors
* Enforce business rules
* Improve user experience

---

## 3. Which event is mainly used for Selection Screen validation?

**Answer:**

```abap
AT SELECTION-SCREEN.
```

---

## 4. Which event validates a specific field?

**Answer:**

```abap
AT SELECTION-SCREEN ON p_matnr.
```

---

## 5. Which event validates a Select-Option?

**Answer:**

```abap
AT SELECTION-SCREEN ON s_matnr.
```

or

```abap
AT SELECTION-SCREEN ON END OF s_matnr.
```

---

## 6. Which message type stops report execution?

**Answer:**

```text
MESSAGE ... TYPE 'E'
```

---

## 7. Which message type displays a warning?

**Answer:**

```text
MESSAGE ... TYPE 'W'
```

---

## 8. Which message type displays information?

**Answer:**

```text
MESSAGE ... TYPE 'I'
```

---

## 9. Which message type displays a success message?

**Answer:**

```text
MESSAGE ... TYPE 'S'
```

---

## 10. What happens after an Error Message (TYPE 'E')?

**Answer:**

The report execution stops, and the cursor returns to the Selection Screen so the user can correct the input.

---

# Intermediate Level

## 11. What is the difference between `AT SELECTION-SCREEN` and `AT SELECTION-SCREEN ON`?

**Answer:**

* **AT SELECTION-SCREEN** → Validates all input fields together.
* **AT SELECTION-SCREEN ON field** → Validates only a specific field immediately after user input.

---

## 12. What is `AT SELECTION-SCREEN ON BLOCK`?

**Answer:**

It validates all fields within a specific Selection Screen block.

Example:

```abap
AT SELECTION-SCREEN ON BLOCK b1.
```

---

## 13. What is `AT SELECTION-SCREEN ON END OF`?

**Answer:**

It is mainly used to validate the complete contents of a Select-Option after the user finishes entering all ranges.

---

## 14. Can multiple validations be written in one report?

**Answer:**

Yes.

A report can contain multiple validation events for different fields, blocks, and select-options.

---

## 15. How do you validate that a quantity is greater than zero?

**Answer:**

```abap
IF p_qty <= 0.
  MESSAGE 'Quantity must be greater than zero' TYPE 'E'.
ENDIF.
```

---

## 16. How do you validate a date range?

**Answer:**

```abap
IF p_from > p_to.
  MESSAGE 'From Date cannot be greater than To Date' TYPE 'E'.
ENDIF.
```

---

## 17. Can database validation be performed?

**Answer:**

Yes.

Example:

```abap
SELECT SINGLE matnr
FROM mara
INTO @DATA(lv_matnr)
WHERE matnr = @p_matnr.
```

---

## 18. Can validation depend on another field?

**Answer:**

Yes.

This is called **cross-field validation**.

---

## 19. Can validation be skipped?

**Answer:**

Yes.

Validation can be performed conditionally based on user selections or business logic.

---

## 20. Should validation be written in START-OF-SELECTION?

**Answer:**

No.

Validation should be completed before report execution using Selection Screen events.

---

# Advanced Level

## 21. Why should field-level validation be preferred?

**Answer:**

Because users receive immediate feedback on the incorrect field, improving usability.

---

## 22. How do you validate Select-Options containing multiple ranges?

**Answer:**

Using:

```abap
LOOP AT s_matnr.
```

or

```abap
AT SELECTION-SCREEN ON END OF s_matnr.
```

---

## 23. What is cross-field validation?

**Answer:**

Validation where one field depends on another.

Example:

* From Date ≤ To Date
* Minimum Quantity ≤ Maximum Quantity
* Start Plant and End Plant

---

## 24. Can business rules be validated?

**Answer:**

Yes.

Example:

* Customer belongs to selected Company Code.
* Material is active.
* Sales Organization is authorized.

---

## 25. Why should validation messages be user-friendly?

**Answer:**

Clear messages help users correct mistakes quickly and reduce support requests.

---

## 26. Can validation be performed using Function Modules?

**Answer:**

Yes.

SAP standard function modules or custom function modules can be used for reusable validation logic.

---

## 27. Can authorization checks be performed during validation?

**Answer:**

Yes.

Using:

```abap
AUTHORITY-CHECK
```

before report execution.

---

## 28. Can validation call database tables?

**Answer:**

Yes.

Master data tables such as MARA, KNA1, LFA1, and VBAK are commonly checked.

---

## 29. Can validation be different for different report modes?

**Answer:**

Yes.

Business logic can determine which validations should be executed.

---

## 30. Why is Selection Screen validation considered a best practice?

**Answer:**

Because invalid data is rejected before report processing, improving system performance and data quality.

---

# Scenario-Based Questions

## 31. Users should not enter a future posting date. How would you validate it?

**Answer:**

Compare the entered date with `SY-DATUM` and raise an error if it is greater.

---

## 32. Users enter Quantity as zero. What should happen?

**Answer:**

Display an error message and prevent report execution.

---

## 33. The "From Date" is greater than the "To Date". How would you handle it?

**Answer:**

Perform cross-field validation and display an error message.

---

## 34. A Material Number must exist before processing. How would you validate it?

**Answer:**

Check the Material in table `MARA` using `SELECT SINGLE`.

---

## 35. Company Code should be mandatory only when "Company Report" is selected. How would you implement this?

**Answer:**

Use MODIF ID to display the field and validate it conditionally.

---

## 36. Users should receive a warning if the selected date range exceeds one year. Which message type should be used?

**Answer:**

`MESSAGE TYPE 'W'`

---

## 37. The user selects a Customer that belongs to another Sales Organization. How would you validate it?

**Answer:**

Read the relevant master data tables and compare the entered values against the business rules.

---

## 38. How do you validate uploaded file paths?

**Answer:**

Check whether the file path is entered and verify that the file exists before processing.

---

## 39. Users should not execute the report without entering at least one selection criterion. How would you implement this?

**Answer:**

In `AT SELECTION-SCREEN`, check whether all parameters and select-options are initial. If so, display an error message.

---

## 40. Why should validations be completed before START-OF-SELECTION?

**Answer:**

To prevent unnecessary database access and ensure only valid input reaches the report logic.

---

# Real-Time Project Questions

## 41. What validations have you implemented in your project?

**Answer:**

Examples:

* Date Range Validation
* Material Existence Check
* Customer Validation
* Company Code Validation
* Plant Validation
* Mandatory Input Validation
* Authorization Check
* File Path Validation

---

## 42. How do you validate a Sales Order entered by the user?

**Answer:**

Check whether the Sales Order exists in table `VBAK` using `SELECT SINGLE`. If it does not exist, display an error message.

---

## 43. Have you implemented authorization validation?

**Answer:**

Yes.

Using:

```abap
AUTHORITY-CHECK OBJECT ...
```

before processing the report.

---

## 44. Why are validations important in business reports?

**Answer:**

They ensure that only valid and authorized data is processed, reducing business errors and improving report accuracy.

---

## 45. What is the most common validation in SAP reports?

**Answer:**

* Mandatory field checks
* Date validations
* Master data existence checks
* Authorization checks
* Cross-field validations

---

# Rapid Fire Questions

### 46. Which event validates the entire Selection Screen?

**Answer:** `AT SELECTION-SCREEN`

---

### 47. Which event validates a single field?

**Answer:** `AT SELECTION-SCREEN ON field`

---

### 48. Which event validates a Selection Screen block?

**Answer:** `AT SELECTION-SCREEN ON BLOCK`

---

### 49. Which event validates a Select-Option after all entries are completed?

**Answer:** `AT SELECTION-SCREEN ON END OF`

---

### 50. Which message type stops report execution?

**Answer:** `E`

---

### 51. Which message type displays a warning?

**Answer:** `W`

---

### 52. Which message type displays information?

**Answer:** `I`

---

### 53. Which message type displays success?

**Answer:** `S`

---

### 54. Which ABAP statement is commonly used to validate database records?

**Answer:** `SELECT SINGLE`

---

### 55. Which statement checks user authorization?

**Answer:** `AUTHORITY-CHECK`

---

# Tricky Interview Questions

## 56. What is the difference between `MESSAGE TYPE 'E'` and `MESSAGE TYPE 'W'`?

**Answer:**

* **TYPE 'E'** → Stops report execution and returns the user to the Selection Screen.
* **TYPE 'W'** → Displays a warning but allows the user to continue processing after acknowledgment.

---

## 57. Can validation be performed after `START-OF-SELECTION`?

**Answer:**

Technically yes, but it is **not recommended**. Validation should occur on the Selection Screen before the report begins processing.

---

## 58. What is the difference between `AT SELECTION-SCREEN ON field` and `AT SELECTION-SCREEN ON END OF select-option`?

**Answer:**

* `ON field` validates a single parameter or a specific select-option field.
* `ON END OF select-option` validates the complete select-option range after all entries have been entered.

---

## 59. Is checking only the data type enough for validation?

**Answer:**

No.

Data type validation ensures correct format, but business validations (such as existence checks, authorization checks, and cross-field rules) are equally important.

---

## 60. Which is better for validating a Material Number: checking its length or verifying its existence in `MARA`?

**Answer:**

Verifying its existence in **`MARA`** is the correct approach. Checking only the length confirms the format but does not guarantee that the material actually exists in the SAP system.
