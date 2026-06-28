# Interview Questions - ZSS_05_PUSHBUTTON_FUNCTIONKEY

This document contains frequently asked SAP ABAP interview questions related to **Push Buttons** and **Function Keys** used in Selection Screens. The questions are categorized from beginner to advanced level, including real-time scenarios and tricky interview questions commonly asked in SAP ABAP interviews.

---

# Beginner Level

## 1. What is a Push Button in SAP ABAP?

**Answer:**

A Push Button is a clickable button displayed on the Selection Screen that allows users to perform a custom action without executing the report.

Example:

```abap
SELECTION-SCREEN PUSHBUTTON 2(20) btn1 USER-COMMAND PB1.
```

---

## 2. Why do we use Push Buttons?

**Answer:**

Push Buttons are used to:

- Display Help
- Reset Input Fields
- Preview Data
- Load Default Values
- Open Documentation
- Execute Custom Actions

---

## 3. What is a Function Key?

**Answer:**

Function Keys are toolbar buttons (Function Key 1 to Function Key 5) available on the Selection Screen that execute predefined or custom actions.

---

## 4. How many Function Keys can be created?

**Answer:**

SAP supports **5 Function Keys**.

```abap
SELECTION-SCREEN FUNCTION KEY 1.
```

through

```abap
SELECTION-SCREEN FUNCTION KEY 5.
```

---

## 5. Which keyword is used to create a Push Button?

**Answer:**

```abap
SELECTION-SCREEN PUSHBUTTON
```

---

## 6. Which keyword is used to create a Function Key?

**Answer:**

```abap
SELECTION-SCREEN FUNCTION KEY
```

---

## 7. What is USER-COMMAND?

**Answer:**

`USER-COMMAND` assigns a unique function code to a Push Button, allowing the program to identify which button was pressed.

Example:

```abap
SELECTION-SCREEN PUSHBUTTON 2(20) btn_help USER-COMMAND HELP.
```

---

## 8. Where is the pressed button identified?

**Answer:**

Using:

```abap
SSCRFIELDS-UCOMM
```

---

## 9. Which structure stores Selection Screen function codes?

**Answer:**

```abap
SSCRFIELDS
```

---

## 10. Can a Push Button execute a report?

**Answer:**

Yes.

It can trigger business logic, call another report, or execute a transaction.

---

# Intermediate Level

## 11. Which event handles Push Button actions?

**Answer:**

```abap
AT SELECTION-SCREEN.
```

---

## 12. How do you identify which Push Button was pressed?

**Answer:**

```abap
CASE sscrfields-ucomm.
  WHEN 'HELP'.
  WHEN 'RESET'.
ENDCASE.
```

---

## 13. Can multiple Push Buttons be created?

**Answer:**

Yes.

Multiple Push Buttons can be placed anywhere on the Selection Screen.

---

## 14. Can Push Buttons and Function Keys be used together?

**Answer:**

Yes.

They are commonly used together in SAP reports.

---

## 15. How do you assign text to a Function Key?

**Answer:**

Using:

```abap
sscrfields-functxt_01 = 'Help'.
```

---

## 16. Which include contains SSCRFIELDS?

**Answer:**

```abap
TABLES sscrfields.
```

---

## 17. Can Push Buttons perform validation?

**Answer:**

Yes.

They can trigger custom validation before report execution.

---

## 18. Can a Push Button clear Selection Screen fields?

**Answer:**

Yes.

Reset the parameter values inside the Push Button event.

---

## 19. Can a Push Button call another transaction?

**Answer:**

Yes.

Example:

```abap
CALL TRANSACTION 'MM03'.
```

---

## 20. Can Function Keys display documentation?

**Answer:**

Yes.

They are commonly used for Help, User Guide, or Documentation.

---

# Advanced Level

## 21. What is SSCRFIELDS-UCOMM?

**Answer:**

It stores the function code of the Push Button or Function Key pressed by the user.

---

## 22. Can Push Buttons change the Selection Screen dynamically?

**Answer:**

Yes.

By combining them with:

- MODIF ID
- LOOP AT SCREEN
- MODIFY SCREEN

---

## 23. Which event is used for dynamic screen modification?

**Answer:**

```abap
AT SELECTION-SCREEN OUTPUT.
```

---

## 24. Can Push Buttons execute different logic?

**Answer:**

Yes.

Each USER-COMMAND can execute separate business logic.

---

## 25. Can Function Keys navigate to another report?

**Answer:**

Yes.

Using:

- SUBMIT
- CALL TRANSACTION
- LEAVE TO TRANSACTION

---

## 26. Can Push Buttons open popup windows?

**Answer:**

Yes.

Using function modules like:

```text
POPUP_TO_DISPLAY_TEXT
```

or

```text
POPUP_TO_CONFIRM
```

---

## 27. Can Push Buttons trigger file download?

**Answer:**

Yes.

They can call download logic before report execution.

---

## 28. Can Push Buttons upload files?

**Answer:**

Yes.

They are often used to trigger file selection dialogs.

---

## 29. Can Push Buttons execute without pressing F8?

**Answer:**

Yes.

That is one of their primary advantages.

---

## 30. Why are Push Buttons useful?

**Answer:**

They improve usability by allowing users to perform quick actions directly from the Selection Screen.

---

# Scenario-Based Questions

## 31. Users want a Help button on the Selection Screen. Which control would you use?

**Answer:**

Push Button.

---

## 32. Users want to clear all entered values with one click. How would you implement it?

**Answer:**

Create a Push Button with a RESET function code and clear all parameters.

---

## 33. Users need a button to download an Excel template before uploading data. Which control is suitable?

**Answer:**

Push Button.

---

## 34. Users should navigate to transaction MM03 directly from the Selection Screen. Is it possible?

**Answer:**

Yes.

Using:

```abap
CALL TRANSACTION 'MM03'.
```

---

## 35. Users want to preview selected data before executing the report. Which control would you use?

**Answer:**

Push Button.

---

## 36. A report should open documentation when the user clicks a toolbar button. Which feature should be used?

**Answer:**

Function Key.

---

## 37. How do you determine which button the user clicked?

**Answer:**

Using:

```abap
SSCRFIELDS-UCOMM
```

---

## 38. Can one Push Button execute multiple actions?

**Answer:**

Yes.

Based on the program logic.

---

## 39. Can a Push Button validate mandatory fields before execution?

**Answer:**

Yes.

Validation can be performed before executing business logic.

---

## 40. Can Push Buttons improve user experience?

**Answer:**

Yes.

They reduce unnecessary report execution and provide quick access to common actions.

---

# Real-Time Project Questions

## 41. Where have you used Push Buttons in your project?

**Answer:**

Examples:

- Download Excel Template
- Upload File
- Preview Report
- Reset Screen
- Display Help
- Display Report Version

---

## 42. Where have you used Function Keys?

**Answer:**

Examples:

- Help
- Documentation
- User Manual
- Report Information
- Technical Details

---

## 43. Why do business users prefer Push Buttons?

**Answer:**

They allow quick access to common actions without leaving the Selection Screen.

---

## 44. Have you used Push Buttons with File Upload?

**Answer:**

Yes.

A Push Button is commonly used to open the file browser before uploading data.

---

## 45. How do Push Buttons improve report usability?

**Answer:**

They simplify navigation, reduce manual steps, and provide direct access to frequently used functions.

---

# Rapid Fire Questions

### 46. Which statement creates a Push Button?

**Answer:** `SELECTION-SCREEN PUSHBUTTON`

---

### 47. Which statement creates a Function Key?

**Answer:** `SELECTION-SCREEN FUNCTION KEY`

---

### 48. Which addition assigns a function code?

**Answer:** `USER-COMMAND`

---

### 49. Which structure stores function codes?

**Answer:** `SSCRFIELDS`

---

### 50. Which field stores the selected function code?

**Answer:** `SSCRFIELDS-UCOMM`

---

### 51. How many Function Keys are supported?

**Answer:** Five.

---

### 52. Which event usually handles Push Button actions?

**Answer:** `AT SELECTION-SCREEN`

---

### 53. Can Push Buttons execute without pressing F8?

**Answer:** Yes.

---

### 54. Can Push Buttons call transactions?

**Answer:** Yes.

---

### 55. Can Function Keys display help information?

**Answer:** Yes.

---

# Tricky Interview Questions

## 56. What is the difference between a Push Button and a Function Key?

**Answer:**

- **Push Button:** Displayed directly on the Selection Screen and positioned by the developer.
- **Function Key:** Displayed in the Selection Screen application toolbar (Function Keys 1–5).

---

## 57. Is USER-COMMAND mandatory for a Push Button?

**Answer:**

Yes.

Without `USER-COMMAND`, the program cannot identify which Push Button was pressed.

---

## 58. Can multiple Push Buttons have the same USER-COMMAND?

**Answer:**

Technically yes, but it is **not recommended** because the program cannot distinguish between the buttons.

---

## 59. Can Push Buttons replace Execute (F8)?

**Answer:**

No.

Push Buttons perform custom actions, while **Execute (F8)** starts the report's main processing.

---

## 60. Which is better for frequently used actions such as "Download Template": a Push Button or a Function Key?

**Answer:**

A **Push Button** is generally preferred because it is more visible and intuitive for end users, while Function Keys are better suited for secondary actions like Help or Documentation.