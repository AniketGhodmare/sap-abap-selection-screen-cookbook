# Interview Questions - ZSS_13_SELECTION_EVENTS

This document contains frequently asked SAP ABAP interview questions related to **Selection Screen Events**. These questions cover the complete lifecycle of an SAP Selection Screen, including initialization, validation, dynamic screen modification, F4 Help, F1 Help, function keys, push buttons, and report execution.

---

# Beginner Level

## 1. What are Selection Screen Events in SAP ABAP?

**Answer:**

Selection Screen Events are predefined ABAP events that are triggered during the execution of a report before the actual processing starts. They are mainly used for:

- Setting default values
- Validating user input
- Modifying screen fields
- Handling user actions
- Providing F4/F1 Help

---

## 2. Which event is executed first in a report?

**Answer:**

```abap
INITIALIZATION
```

It is executed before the Selection Screen is displayed.

---

## 3. What is the purpose of the INITIALIZATION event?

**Answer:**

It is used to:

- Assign default values
- Initialize internal tables
- Set default radio buttons
- Set default checkboxes

---

## 4. Which event is used to modify the Selection Screen dynamically?

**Answer:**

```abap
AT SELECTION-SCREEN OUTPUT
```

---

## 5. Which event is triggered when the user presses Execute (F8)?

**Answer:**

```abap
AT SELECTION-SCREEN
```

---

## 6. Which event validates a single field?

**Answer:**

```abap
AT SELECTION-SCREEN ON <field>.
```

Example:

```abap
AT SELECTION-SCREEN ON p_date.
```

---

## 7. Which event is used for Custom F4 Help?

**Answer:**

```abap
AT SELECTION-SCREEN ON VALUE-REQUEST
```

---

## 8. Which event is used for Custom F1 Help?

**Answer:**

```abap
AT SELECTION-SCREEN ON HELP-REQUEST
```

---

## 9. When does START-OF-SELECTION execute?

**Answer:**

Only after all Selection Screen validations are completed successfully.

---

## 10. Why are Selection Screen Events important?

**Answer:**

They allow developers to control user input before business processing begins.

---

# Intermediate Level

## 11. What is the execution sequence of Selection Screen Events?

**Answer:**

Typical sequence:

```
INITIALIZATION

↓

AT SELECTION-SCREEN OUTPUT

↓

Selection Screen Display

↓

User Input

↓

AT SELECTION-SCREEN ON VALUE-REQUEST (if F4)

↓

AT SELECTION-SCREEN ON HELP-REQUEST (if F1)

↓

AT SELECTION-SCREEN ON FIELD

↓

AT SELECTION-SCREEN ON BLOCK

↓

AT SELECTION-SCREEN

↓

START-OF-SELECTION
```

---

## 12. What is the difference between INITIALIZATION and START-OF-SELECTION?

**Answer:**

| INITIALIZATION | START-OF-SELECTION |
|---------------|--------------------|
| Before screen display | After validations |
| Sets defaults | Executes business logic |

---

## 13. What is the purpose of AT SELECTION-SCREEN OUTPUT?

**Answer:**

Used for dynamic screen modification.

Examples:

- Hide fields
- Disable fields
- Enable fields
- Change labels
- Control MODIF IDs

---

## 14. What is AT SELECTION-SCREEN ON BLOCK?

**Answer:**

It validates all fields inside a Selection Screen block.

---

## 15. What is AT SELECTION-SCREEN ON END OF?

**Answer:**

Used to validate the complete Select-Option after all rows are entered.

---

## 16. What is AT SELECTION-SCREEN ON RADIOBUTTON GROUP?

**Answer:**

It validates a radio button group.

---

## 17. What is AT SELECTION-SCREEN ON EXIT-COMMAND?

**Answer:**

It handles:

- Exit
- Cancel
- Back

before leaving the Selection Screen.

---

## 18. Can multiple Selection Screen Events be used in one report?

**Answer:**

Yes.

A report can contain all Selection Screen Events.

---

## 19. Can Selection Screen Events modify field visibility?

**Answer:**

Yes.

Using:

```abap
LOOP AT SCREEN.
MODIFY SCREEN.
ENDLOOP.
```

inside:

```abap
AT SELECTION-SCREEN OUTPUT.
```

---

## 20. Which event is used for Push Buttons?

**Answer:**

```abap
AT SELECTION-SCREEN.
```

using

```abap
sy-ucomm
```

or

```abap
AT SELECTION-SCREEN ON FUNCTION KEY
```

for function keys.

---

# Advanced Level

## 21. What is the difference between AT SELECTION-SCREEN and AT SELECTION-SCREEN ON FIELD?

**Answer:**

| AT SELECTION-SCREEN | AT SELECTION-SCREEN ON FIELD |
|---------------------|------------------------------|
| Validates entire screen | Validates one field |
| Executes after all field checks | Executes immediately for the specified field |

---

## 22. Why should business logic not be written inside Selection Screen Events?

**Answer:**

Selection Screen Events should only handle screen processing and validation. Business logic should be placed in:

```abap
START-OF-SELECTION
```

to improve maintainability.

---

## 23. Can Selection Screen Events stop report execution?

**Answer:**

Yes.

Using:

```abap
MESSAGE e...
```

Execution stops until the user corrects the input.

---

## 24. Which event executes every time the screen refreshes?

**Answer:**

```abap
AT SELECTION-SCREEN OUTPUT
```

---

## 25. Can Selection Screen Events call Function Modules?

**Answer:**

Yes.

Examples:

- Search Helps
- File Dialog
- Authorization Checks

---

## 26. Can Selection Screen Events be used with MODIF ID?

**Answer:**

Yes.

Mostly inside:

```abap
AT SELECTION-SCREEN OUTPUT.
```

---

## 27. Can Selection Screen Events trigger popup messages?

**Answer:**

Yes.

Using:

```abap
MESSAGE
```

or popup Function Modules.

---

## 28. Can F4 Help and Validation exist together?

**Answer:**

Yes.

F4 Help executes first when requested.

Validation occurs later.

---

## 29. Which event is best for enabling/disabling fields?

**Answer:**

```abap
AT SELECTION-SCREEN OUTPUT.
```

---

## 30. Which event is executed after successful validation?

**Answer:**

```abap
START-OF-SELECTION
```

---

# Scenario-Based Questions

## 31. Users want today's date to appear automatically. Which event will you use?

**Answer:**

```abap
INITIALIZATION.
```

---

## 32. A field should become mandatory only when a checkbox is selected. How would you implement this?

**Answer:**

Use:

```abap
AT SELECTION-SCREEN OUTPUT
```

with `MODIF ID` to dynamically control the field, and validate it in `AT SELECTION-SCREEN`.

---

## 33. Users should not enter a future date. Which event should be used?

**Answer:**

```abap
AT SELECTION-SCREEN ON p_date.
```

---

## 34. Material field requires Custom F4 Help. Which event will you use?

**Answer:**

```abap
AT SELECTION-SCREEN ON VALUE-REQUEST
```

---

## 35. A report should hide certain fields depending on the selected Radio Button. How would you implement it?

**Answer:**

Use:

```abap
AT SELECTION-SCREEN OUTPUT.
```

Loop through the `SCREEN` table and modify field properties based on the selected radio button.

---

## 36. The report should stop if no Company Code is entered. Which event is appropriate?

**Answer:**

Validate the field in:

```abap
AT SELECTION-SCREEN.
```

or

```abap
AT SELECTION-SCREEN ON p_bukrs.
```

---

## 37. Users request a Help popup when they press F1. Which event will you use?

**Answer:**

```abap
AT SELECTION-SCREEN ON HELP-REQUEST.
```

---

## 38. The user clicks Cancel on the Selection Screen. Which event can process this action?

**Answer:**

```abap
AT SELECTION-SCREEN ON EXIT-COMMAND.
```

---

## 39. Multiple fields inside a block should be validated together. Which event is best?

**Answer:**

```abap
AT SELECTION-SCREEN ON BLOCK.
```

---

## 40. Why should dynamic screen changes be placed in AT SELECTION-SCREEN OUTPUT?

**Answer:**

Because this event executes every time the Selection Screen is displayed or refreshed, ensuring the screen always reflects the latest user selections.

---

# Real-Time Project Questions

## 41. Which Selection Screen Events have you used in your projects?

**Answer:**

Examples:

- INITIALIZATION
- AT SELECTION-SCREEN OUTPUT
- AT SELECTION-SCREEN
- AT SELECTION-SCREEN ON FIELD
- AT SELECTION-SCREEN ON VALUE-REQUEST
- START-OF-SELECTION

---

## 42. Why did you use INITIALIZATION?

**Answer:**

To set default values such as:

- Current Date
- Company Code
- Plant
- Default Radio Button

---

## 43. Have you dynamically hidden fields?

**Answer:**

Yes.

Using:

```abap
AT SELECTION-SCREEN OUTPUT
```

with:

```abap
SCREEN-ACTIVE
SCREEN-INVISIBLE
SCREEN-INPUT
```

---

## 44. How did you implement Custom F4 Help?

**Answer:**

Using:

```abap
AT SELECTION-SCREEN ON VALUE-REQUEST
```

along with:

```text
F4IF_INT_TABLE_VALUE_REQUEST
```

---

## 45. Why are Selection Screen Events important in real-time projects?

**Answer:**

They improve report usability by:

- Validating input
- Providing dynamic screens
- Offering value help
- Preventing incorrect data before processing

---

# Rapid Fire Questions

### 46. Which event executes first?

**Answer:** `INITIALIZATION`

---

### 47. Which event modifies screen fields?

**Answer:** `AT SELECTION-SCREEN OUTPUT`

---

### 48. Which event validates a field?

**Answer:** `AT SELECTION-SCREEN ON <field>`

---

### 49. Which event handles Custom F4 Help?

**Answer:** `AT SELECTION-SCREEN ON VALUE-REQUEST`

---

### 50. Which event handles Custom F1 Help?

**Answer:** `AT SELECTION-SCREEN ON HELP-REQUEST`

---

### 51. Which event validates a Selection Screen block?

**Answer:** `AT SELECTION-SCREEN ON BLOCK`

---

### 52. Which event validates a Radio Button Group?

**Answer:** `AT SELECTION-SCREEN ON RADIOBUTTON GROUP`

---

### 53. Which event handles Exit or Cancel?

**Answer:** `AT SELECTION-SCREEN ON EXIT-COMMAND`

---

### 54. Which event executes after successful validation?

**Answer:** `START-OF-SELECTION`

---

### 55. Which system field stores the user command?

**Answer:** `SY-UCOMM`

---

# Tricky Interview Questions

## 56. What is the difference between `AT SELECTION-SCREEN` and `START-OF-SELECTION`?

**Answer:**

- `AT SELECTION-SCREEN` is used for **validation and user interaction** before report execution.
- `START-OF-SELECTION` is used for the **main business logic** and executes only after all validations are successful.

---

## 57. What is the difference between `AT SELECTION-SCREEN OUTPUT` and `INITIALIZATION`?

**Answer:**

- `INITIALIZATION` runs **once** before the Selection Screen is displayed and is mainly used for setting default values.
- `AT SELECTION-SCREEN OUTPUT` runs **every time** the Selection Screen is displayed or refreshed and is used for dynamic screen modifications.

---

## 58. Which event is triggered first when the user presses F4?

**Answer:**

```abap
AT SELECTION-SCREEN ON VALUE-REQUEST
```

This event is triggered before the standard input validation process.

---

## 59. Can you perform database updates inside `AT SELECTION-SCREEN`?

**Answer:**

Technically yes, but it is **not recommended**.

Database inserts, updates, or deletes should be performed in `START-OF-SELECTION` (or later processing blocks) after successful validation. Selection Screen events should focus on screen handling and validation.

---

## 60. What is the correct order of the most commonly used Selection Screen Events?

**Answer:**

```
INITIALIZATION

↓

AT SELECTION-SCREEN OUTPUT

↓

Selection Screen Display

↓

AT SELECTION-SCREEN ON VALUE-REQUEST (if F4)

↓

AT SELECTION-SCREEN ON HELP-REQUEST (if F1)

↓

AT SELECTION-SCREEN ON <FIELD>

↓

AT SELECTION-SCREEN

↓

START-OF-SELECTION
```

Understanding this execution sequence is essential for developing robust and predictable Selection Screen logic in SAP ABAP.