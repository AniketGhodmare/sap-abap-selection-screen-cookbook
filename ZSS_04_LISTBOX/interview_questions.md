# Interview Questions - ZSS_04_LISTBOX

This document contains frequently asked SAP ABAP interview questions related to **List Boxes (Dropdown Lists)** used in Selection Screens. The questions are categorized from beginner to advanced level, including real-time scenarios and tricky interview questions commonly asked in SAP ABAP interviews.

---

# Beginner Level

## 1. What is a List Box in SAP ABAP?

**Answer:**

A List Box (Dropdown) is a Selection Screen control that allows users to select **one value from a predefined list** instead of typing the value manually.

Example:

```abap
PARAMETERS:
  p_type TYPE char10 AS LISTBOX VISIBLE LENGTH 20.
```

---

## 2. Why do we use a List Box?

**Answer:**

A List Box is used to:

- Restrict user input
- Avoid typing mistakes
- Improve user experience
- Display predefined options

---

## 3. Which keyword is used to create a List Box?

**Answer:**

```abap
AS LISTBOX
```

---

## 4. What is the purpose of VISIBLE LENGTH?

**Answer:**

It specifies the visible width of the dropdown on the Selection Screen.

Example:

```abap
PARAMETERS:
  p_mode TYPE char10 AS LISTBOX VISIBLE LENGTH 25.
```

---

## 5. Can users type their own value in a List Box?

**Answer:**

No.

Users can only select one of the available values.

---

## 6. Can multiple values be selected in a List Box?

**Answer:**

No.

A List Box allows only one selected value.

---

## 7. Which statement is used with AS LISTBOX?

**Answer:**

`PARAMETERS`

---

## 8. What is stored in the parameter after selection?

**Answer:**

The **Key** of the selected entry is stored.

---

## 9. What does the user see in the dropdown?

**Answer:**

The **Text/Description** associated with the key.

---

## 10. Is a List Box mandatory?

**Answer:**

No.

It becomes mandatory only if declared with:

```abap
OBLIGATORY
```

---

# Intermediate Level

## 11. Which function module is used to populate a List Box?

**Answer:**

```text
VRM_SET_VALUES
```

---

## 12. Which Type Pool is required for List Boxes?

**Answer:**

```abap
TYPE-POOLS: VRM.
```

---

## 13. Which structure is used for List Box values?

**Answer:**

```abap
VRM_VALUE
```

---

## 14. Which internal table is passed to VRM_SET_VALUES?

**Answer:**

```abap
VRM_VALUES
```

---

## 15. What are the two fields of VRM_VALUE?

**Answer:**

- KEY
- TEXT

---

## 16. When should VRM_SET_VALUES be called?

**Answer:**

Usually in:

- INITIALIZATION
- AT SELECTION-SCREEN OUTPUT

---

## 17. Can default values be assigned to a List Box?

**Answer:**

Yes.

```abap
p_mode = 'A'.
```

Where `A` is the key.

---

## 18. Can List Box values be changed dynamically?

**Answer:**

Yes.

Repopulate the List Box using `VRM_SET_VALUES`.

---

## 19. Can List Boxes be validated?

**Answer:**

Yes.

Using:

```abap
AT SELECTION-SCREEN.
```

or

```abap
AT SELECTION-SCREEN ON p_mode.
```

---

## 20. Can a List Box use Search Help?

**Answer:**

No.

A List Box displays predefined values only.

For large datasets, use F4 Help instead.

---

# Advanced Level

## 21. How does a List Box internally store values?

**Answer:**

Each entry consists of:

- KEY (Stored Value)
- TEXT (Displayed Value)

---

## 22. Why should technical codes be used as Keys?

**Answer:**

Because the business logic works with stable codes, while users see meaningful descriptions.

Example:

```text
Key    Text
A      Create
B      Change
C      Display
```

---

## 23. Can List Box values come from a database table?

**Answer:**

Yes.

Read the database records into an internal table and populate the List Box using `VRM_SET_VALUES`.

---

## 24. Can different List Box values be displayed based on another field?

**Answer:**

Yes.

This can be implemented using:

- MODIF ID
- AT SELECTION-SCREEN OUTPUT
- VRM_SET_VALUES

---

## 25. Can a List Box be disabled dynamically?

**Answer:**

Yes.

Using:

```abap
LOOP AT SCREEN.
  screen-input = 0.
  MODIFY SCREEN.
ENDLOOP.
```

---

## 26. Can a List Box be hidden dynamically?

**Answer:**

Yes.

Using:

- MODIF ID
- LOOP AT SCREEN
- MODIFY SCREEN

---

## 27. Which event is commonly used for dynamic screen modification?

**Answer:**

```abap
AT SELECTION-SCREEN OUTPUT.
```

---

## 28. Can one List Box control another List Box?

**Answer:**

Yes.

This is called a **dependent or cascading dropdown**.

---

## 29. Is VRM_SET_VALUES mandatory?

**Answer:**

Yes.

Without it, the List Box will not display any values.

---

## 30. When should you avoid using a List Box?

**Answer:**

When the number of values is very large (e.g., Materials, Customers, Vendors).

Use Search Help (F4) instead.

---

# Scenario-Based Questions

## 31. Users should select one Report Type from five options. Which control would you use?

**Answer:**

List Box.

---

## 32. Users should choose one Company Category (Domestic or Export). Which control is suitable?

**Answer:**

List Box.

---

## 33. Users need to select one Language from a predefined list. Which control should be used?

**Answer:**

List Box.

---

## 34. The available Cities should change after selecting a Country. Is this possible?

**Answer:**

Yes.

Use cascading List Boxes and repopulate values using `VRM_SET_VALUES`.

---

## 35. Users need to select one Processing Mode (Test or Production). Which control is appropriate?

**Answer:**

List Box.

---

## 36. A report has over 50,000 Materials. Should you use a List Box?

**Answer:**

No.

Use Search Help (F4).

---

## 37. Why should descriptions be displayed instead of technical codes?

**Answer:**

Descriptions improve usability, while technical keys remain available for processing.

---

## 38. A user changes the Report Type. Can the Selection Screen change automatically?

**Answer:**

Yes.

Use `AT SELECTION-SCREEN OUTPUT` to modify the screen dynamically.

---

## 39. How do you ensure users select only valid values?

**Answer:**

By populating the List Box with predefined values and validating the selection.

---

## 40. Can the selected List Box value control report logic?

**Answer:**

Yes.

The selected key can determine different processing paths.

---

# Real-Time Project Questions

## 41. Where have you used a List Box in your project?

**Answer:**

Examples:

- Report Type
- Processing Mode
- Output Format
- Language Selection
- Document Category

---

## 42. Why do business users prefer List Boxes?

**Answer:**

Because they eliminate typing errors and simplify data entry.

---

## 43. Have you populated a List Box dynamically?

**Answer:**

Yes.

Using `VRM_SET_VALUES` after fetching values from a configuration table.

---

## 44. Why shouldn't Materials or Customers be displayed in a List Box?

**Answer:**

Because the number of values is too large, making the dropdown slow and difficult to use.

---

## 45. How do you populate a List Box from a customizing table?

**Answer:**

Read the customizing table into an internal table, build `VRM_VALUES`, and call `VRM_SET_VALUES`.

---

# Rapid Fire Questions

### 46. Which keyword creates a dropdown?

**Answer:** `AS LISTBOX`

---

### 47. Which statement supports List Boxes?

**Answer:** `PARAMETERS`

---

### 48. Which function module populates a List Box?

**Answer:** `VRM_SET_VALUES`

---

### 49. Which Type Pool is required?

**Answer:** `VRM`

---

### 50. Which structure stores one dropdown entry?

**Answer:** `VRM_VALUE`

---

### 51. Which internal table stores all dropdown values?

**Answer:** `VRM_VALUES`

---

### 52. Which field is stored after selection?

**Answer:** `KEY`

---

### 53. Which field is displayed to the user?

**Answer:** `TEXT`

---

### 54. Can multiple values be selected in a List Box?

**Answer:** No.

---

### 55. Which event is commonly used to refresh dropdown values?

**Answer:** `AT SELECTION-SCREEN OUTPUT`

---

# Tricky Interview Questions

## 56. Does a List Box store the displayed text?

**Answer:**

No.

It stores only the **KEY**. The **TEXT** is displayed to the user.

---

## 57. Can you populate a List Box without calling VRM_SET_VALUES?

**Answer:**

No.

Without `VRM_SET_VALUES`, the dropdown will be empty.

---

## 58. What happens if the default key does not exist in the List Box?

**Answer:**

The default value is ignored, and no valid selection is made.

---

## 59. Which is better for selecting one option from three fixed values: Radio Buttons or a List Box?

**Answer:**

Usually **Radio Buttons**, because all options are visible without opening a dropdown. A List Box is better when there are many predefined values.

---

## 60. Which control would you use for selecting one Material Number from thousands of records: List Box or Search Help?

**Answer:**

**Search Help (F4)**.

A List Box is suitable only for a small number of predefined values, while Search Help is optimized for large datasets.