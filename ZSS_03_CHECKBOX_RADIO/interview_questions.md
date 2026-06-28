# Interview Questions - ZSS_03_CHECKBOX_RADIO

This document contains frequently asked SAP ABAP interview questions related to **Checkboxes** and **Radio Buttons** used in Selection Screens. The questions are categorized from beginner to advanced level, including real-time scenarios and tricky interview questions commonly asked in SAP ABAP interviews.

---

# Beginner Level

## 1. What is a Checkbox in SAP ABAP?

**Answer:**

A Checkbox is a Selection Screen element that allows the user to make a **Yes/No (Boolean)** choice.

Example:

```abap
PARAMETERS: p_active AS CHECKBOX.
```

---

## 2. What value does a Checkbox store when selected?

**Answer:**

* `'X'` → Selected
* `' '` (Blank) → Not Selected

---

## 3. Can multiple Checkboxes be selected simultaneously?

**Answer:**

Yes.

Each Checkbox is independent, so users can select any combination of checkboxes.

---

## 4. What is a Radio Button in SAP ABAP?

**Answer:**

A Radio Button allows users to select **only one option** from a group of mutually exclusive choices.

Example:

```abap
PARAMETERS:
  p_create RADIOBUTTON GROUP grp1,
  p_change RADIOBUTTON GROUP grp1,
  p_display RADIOBUTTON GROUP grp1.
```

---

## 5. Why do Radio Buttons require a group?

**Answer:**

Radio Buttons must belong to the same `RADIOBUTTON GROUP` so SAP knows that only one option can be selected at a time.

---

## 6. Can more than one Radio Button be selected in the same group?

**Answer:**

No.

Only one Radio Button in a group can be selected.

---

## 7. Can multiple Radio Button groups exist on the same Selection Screen?

**Answer:**

Yes.

Each group works independently.

---

## 8. How do you set a default Radio Button?

**Answer:**

Using the `DEFAULT 'X'` addition.

Example:

```abap
PARAMETERS:
  p_display RADIOBUTTON GROUP grp1 DEFAULT 'X'.
```

---

## 9. Can a Checkbox have a default value?

**Answer:**

Yes.

```abap
PARAMETERS:
  p_test AS CHECKBOX DEFAULT 'X'.
```

---

## 10. When should you use a Checkbox instead of a Radio Button?

**Answer:**

Use a Checkbox when multiple independent options can be selected.

---

# Intermediate Level

## 11. When should you use Radio Buttons?

**Answer:**

When users must select **only one** option.

Example:

* Create
* Change
* Display

---

## 12. What happens if no Radio Button has a DEFAULT option?

**Answer:**

SAP automatically selects the first Radio Button in the group.

---

## 13. Can Checkboxes and Radio Buttons be displayed on the same Selection Screen?

**Answer:**

Yes.

They are commonly used together in SAP reports.

---

## 14. How do you check whether a Checkbox is selected?

**Answer:**

```abap
IF p_active = 'X'.
  " Business Logic
ENDIF.
```

---

## 15. How do you determine which Radio Button is selected?

**Answer:**

```abap
IF p_create = 'X'.

ELSEIF p_change = 'X'.

ELSEIF p_display = 'X'.

ENDIF.
```

---

## 16. Can Checkboxes be mandatory?

**Answer:**

No.

Checkboxes cannot be declared with `OBLIGATORY`.

Validation must be implemented manually.

---

## 17. Can Radio Buttons be mandatory?

**Answer:**

One Radio Button is always selected in a group, so additional mandatory validation is generally not required.

---

## 18. Which Selection Screen event is commonly used to validate Checkbox and Radio Button values?

**Answer:**

```abap
AT SELECTION-SCREEN.
```

---

## 19. Can Comments be displayed beside Checkboxes and Radio Buttons?

**Answer:**

Yes.

Using:

```abap
SELECTION-SCREEN COMMENT.
```

---

## 20. Can Checkboxes and Radio Buttons be placed on the same line?

**Answer:**

Yes.

Using:

* `SELECTION-SCREEN BEGIN OF LINE`
* `SELECTION-SCREEN POSITION`
* `SELECTION-SCREEN END OF LINE`

---

# Advanced Level

## 21. How can you enable or disable fields based on a Checkbox?

**Answer:**

Using:

* `MODIF ID`
* `AT SELECTION-SCREEN OUTPUT`
* `LOOP AT SCREEN`
* `MODIFY SCREEN`

---

## 22. Can Radio Buttons dynamically show or hide fields?

**Answer:**

Yes.

This is one of the most common real-time uses of Radio Buttons.

---

## 23. Which event is used for dynamic screen modification?

**Answer:**

```abap
AT SELECTION-SCREEN OUTPUT.
```

---

## 24. Can business logic change based on the selected Radio Button?

**Answer:**

Yes.

Different processing logic can be executed for each Radio Button option.

---

## 25. How do you clear dependent fields when a Checkbox is unchecked?

**Answer:**

Clear the fields during `AT SELECTION-SCREEN` or `AT SELECTION-SCREEN OUTPUT`.

---

## 26. Can multiple Radio Button groups exist in one report?

**Answer:**

Yes.

Each group functions independently.

---

## 27. Can Checkboxes be used together with MODIF ID?

**Answer:**

Yes.

Checkboxes are frequently used to control dynamic screen behavior.

---

## 28. Can Radio Buttons trigger different validations?

**Answer:**

Yes.

Each selected option can have its own validation logic.

---

## 29. Can Checkboxes be used to control file upload fields?

**Answer:**

Yes.

For example, enabling or disabling a file upload parameter.

---

## 30. How do SAP standard reports use Radio Buttons?

**Answer:**

Commonly for selecting processing modes such as:

* Create
* Change
* Display
* Simulation
* Test Run

---

# Scenario-Based Questions

## 31. Users should choose only one report type (Summary or Detailed). Which control should you use?

**Answer:**

Radio Buttons.

---

## 32. Users can export the report to Excel, PDF, or Email simultaneously. Which control should you use?

**Answer:**

Checkboxes.

---

## 33. A report should display additional fields only when "Advanced Mode" is selected. How would you implement this?

**Answer:**

Use a Checkbox or Radio Button with `MODIF ID` and `AT SELECTION-SCREEN OUTPUT`.

---

## 34. Users can select either Create, Change, or Display mode. Which control is most suitable?

**Answer:**

Radio Buttons.

---

## 35. Users should be able to enable or disable email notifications. Which control should you use?

**Answer:**

Checkbox.

---

## 36. Users selected "Create" mode. How do you prevent them from entering Display-only fields?

**Answer:**

Disable the fields dynamically using `LOOP AT SCREEN` and `MODIFY SCREEN`.

---

## 37. A report should execute different SQL queries depending on the selected Radio Button. Is this possible?

**Answer:**

Yes.

Business logic can be controlled based on the selected Radio Button.

---

## 38. Users can optionally display deleted records. Which control should you use?

**Answer:**

Checkbox.

---

## 39. Why shouldn't Radio Buttons be used for independent options?

**Answer:**

Because Radio Buttons allow only one selection within a group.

---

## 40. Why are Checkboxes commonly used for optional features?

**Answer:**

Because users can independently enable or disable each option.

---

# Real-Time Project Questions

## 41. Where have you used Checkboxes in your project?

**Answer:**

Examples:

* Include Archived Records
* Display Header
* Export to Excel
* Test Run
* Background Processing

---

## 42. Where have you used Radio Buttons in your project?

**Answer:**

Examples:

* Create / Change / Display
* Summary / Detailed Report
* Local File / Application Server
* Full Upload / Incremental Upload

---

## 43. How do Radio Buttons improve user experience?

**Answer:**

They prevent invalid combinations by allowing only one valid choice.

---

## 44. Why do business users prefer Checkboxes for optional settings?

**Answer:**

Because they can enable multiple independent features simultaneously.

---

## 45. Have you used Checkboxes with dynamic screen modification?

**Answer:**

Yes.

Checkboxes are frequently used to show, hide, enable, or disable dependent fields dynamically.

---

# Rapid Fire Questions

### 46. Which control accepts Yes/No input?

**Answer:** Checkbox

---

### 47. Which control allows only one selection?

**Answer:** Radio Button

---

### 48. Which value represents a selected Checkbox?

**Answer:** `'X'`

---

### 49. Which value represents an unselected Checkbox?

**Answer:** Blank (`' '`)

---

### 50. Which keyword groups Radio Buttons?

**Answer:** `RADIOBUTTON GROUP`

---

### 51. Can multiple Checkboxes be selected?

**Answer:** Yes

---

### 52. Can multiple Radio Buttons in the same group be selected?

**Answer:** No

---

### 53. Which event is used for dynamic screen changes?

**Answer:** `AT SELECTION-SCREEN OUTPUT`

---

### 54. Can Checkboxes control MODIF ID fields?

**Answer:** Yes

---

### 55. Which control is best for selecting report mode?

**Answer:** Radio Button

---

# Tricky Interview Questions

## 56. Is a Checkbox a Boolean data type?

**Answer:**

Not exactly.

Internally, it is a character field that stores:

* `'X'`
* `' '` (Blank)

---

## 57. Can Radio Buttons exist without a RADIOBUTTON GROUP?

**Answer:**

No.

Every Radio Button must belong to a group.

---

## 58. What happens if all Radio Buttons in a group are declared without DEFAULT?

**Answer:**

SAP automatically selects the first Radio Button.

---

## 59. Can a Checkbox be declared with OBLIGATORY?

**Answer:**

No.

Mandatory Checkbox validation must be implemented manually.

---

## 60. Which is better for "Create / Change / Display" options: Three Checkboxes or Three Radio Buttons?

**Answer:**

Three **Radio Buttons**.

Only one mode should be selected at a time, making Radio Buttons the correct choice.
