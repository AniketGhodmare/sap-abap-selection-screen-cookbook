# Interview Questions - ZSS_01_PARAMETERS

This document contains frequently asked SAP ABAP interview questions related to the **PARAMETERS** statement used in Selection Screens.

---

# Beginner Level

## 1. What is `PARAMETERS` in SAP ABAP?

**Answer:**

`PARAMETERS` is a Selection Screen statement used to create a **single input field** that accepts one value from the user.

**Example**

```abap
PARAMETERS: p_matnr TYPE mara-matnr.
```

---

## 2. Why do we use `PARAMETERS`?

**Answer:**

`PARAMETERS` is used whenever a report requires only **one input value** from the user.

Examples:

* Employee ID
* Sales Order Number
* Company Code
* Material Number

---

## 3. What is the difference between `PARAMETERS` and `SELECT-OPTIONS`?

| PARAMETERS      | SELECT-OPTIONS  |
| --------------- | --------------- |
| Single Value    | Multiple Values |
| One Input Field | Range Table     |
| No Intervals    | Supports Ranges |
| Simpler         | More Flexible   |

---

## 4. Can `PARAMETERS` accept multiple values?

**Answer:**

No.

A parameter accepts only one value.

For multiple values or ranges, use `SELECT-OPTIONS`.

---

## 5. Where are `PARAMETERS` displayed?

**Answer:**

On the Selection Screen before report execution.

---

## 6. What data types can be used with `PARAMETERS`?

Examples include:

* CHAR
* NUMC
* STRING
* DATS
* TIMS
* INT4
* CURR
* QUAN
* DEC
* Data Elements
* Dictionary Fields

---

## 7. Can we reference a database field in PARAMETERS?

**Answer:**

Yes.

```abap
PARAMETERS:
    p_matnr TYPE mara-matnr.
```

---

## 8. What is the advantage of using Dictionary fields?

**Answer:**

* Automatic field length
* Automatic data type
* Search Help
* Domain validation
* Better maintainability

---

## 9. What is the default length of a parameter?

**Answer:**

The length depends on the assigned data type or Data Element.

---

## 10. Can we display default values?

**Answer:**

Yes.

```abap
PARAMETERS:
    p_date TYPE sy-datum DEFAULT sy-datum.
```

---

# Intermediate Level

## 11. What is the purpose of `OBLIGATORY`?

**Answer:**

It makes a field mandatory before the report can execute.

```abap
PARAMETERS:
    p_matnr TYPE mara-matnr OBLIGATORY.
```

---

## 12. What happens if an obligatory field is left empty?

**Answer:**

SAP displays an error message and prevents report execution.

---

## 13. What is `LOWER CASE`?

**Answer:**

It allows lowercase characters in character fields.

Without `LOWER CASE`, SAP automatically converts input to uppercase.

---

## 14. Give an example of `LOWER CASE`.

```abap
PARAMETERS:
    p_email TYPE char50 LOWER CASE.
```

---

## 15. What is `NO-DISPLAY`?

**Answer:**

It hides the field from the Selection Screen while still allowing it to be used internally.

---

## 16. When is `NO-DISPLAY` used?

Examples:

* Hidden flags
* Technical parameters
* Background processing
* Internal controls

---

## 17. Can a hidden parameter have a default value?

**Answer:**

Yes.

```abap
PARAMETERS:
    p_test TYPE c NO-DISPLAY DEFAULT 'X'.
```

---

## 18. How do you validate a parameter?

**Answer:**

Using:

```abap
AT SELECTION-SCREEN.
```

or

```abap
AT SELECTION-SCREEN ON p_matnr.
```

---

## 19. Which event is used for field-level validation?

**Answer:**

```abap
AT SELECTION-SCREEN ON p_field.
```

---

## 20. Which event is used for complete screen validation?

**Answer:**

```abap
AT SELECTION-SCREEN.
```

---

# Advanced Level

## 21. How do you provide F4 Help for a parameter?

**Answer:**

Using:

```abap
AT SELECTION-SCREEN
ON VALUE-REQUEST FOR p_matnr.
```

---

## 22. How do you provide F1 Help?

**Answer:**

Using:

```abap
AT SELECTION-SCREEN
ON HELP-REQUEST FOR p_matnr.
```

---

## 23. How can you dynamically hide a parameter?

**Answer:**

Using:

* MODIF ID
* LOOP AT SCREEN
* SCREEN-ACTIVE
* SCREEN-INVISIBLE

---

## 24. How do you disable a parameter dynamically?

```abap
LOOP AT SCREEN.

IF screen-group1 = 'ABC'.

screen-input = 0.

MODIFY SCREEN.

ENDIF.

ENDLOOP.
```

---

## 25. Which event is used for dynamic screen modification?

**Answer:**

```abap
AT SELECTION-SCREEN OUTPUT.
```

---

## 26. Can parameters be modified at runtime?

**Answer:**

Yes.

Using:

* LOOP AT SCREEN
* MODIFY SCREEN

---

## 27. How can you change the default value dynamically?

**Answer:**

During the `INITIALIZATION` event.

---

## 28. What is the execution sequence of Selection Screen events?

1. INITIALIZATION
2. AT SELECTION-SCREEN OUTPUT
3. User Input
4. AT SELECTION-SCREEN
5. START-OF-SELECTION

---

## 29. Can PARAMETERS be grouped?

**Answer:**

Yes.

Using:

* BLOCK
* BEGIN OF LINE
* END OF LINE
* COMMENT

---

## 30. Can PARAMETERS be displayed in multiple blocks?

**Answer:**

Yes.

This improves readability and user experience.

---

# Scenario-Based Questions

## 31. A user should enter only one Material Number. Which statement would you use?

**Answer:**

`PARAMETERS`

---

## 32. The user should enter multiple Material Numbers. Which statement would you use?

**Answer:**

`SELECT-OPTIONS`

---

## 33. You want the Company Code to be mandatory. How will you do it?

**Answer:**

```abap
PARAMETERS:
    p_bukrs TYPE bukrs OBLIGATORY.
```

---

## 34. You want today's date to appear automatically. How?

**Answer:**

```abap
PARAMETERS:
    p_date TYPE sy-datum DEFAULT sy-datum.
```

---

## 35. You want to hide a technical flag from users. Which option will you use?

**Answer:**

`NO-DISPLAY`

---

## 36. Users should be able to enter email addresses in lowercase. What will you use?

**Answer:**

`LOWER CASE`

---

## 37. The user enters an invalid Sales Order Number. Where should you validate it?

**Answer:**

```abap
AT SELECTION-SCREEN ON p_vbeln.
```

---

## 38. When would you choose `PARAMETERS` over `SELECT-OPTIONS`?

**Answer:**

Whenever only one input value is required and ranges or multiple values are not needed.

---

## 39. How do SAP standard reports improve the usability of parameter fields?

**Answer:**

By using:

* Default values
* Search Helps
* Proper labels
* Validation
* Logical grouping using blocks

---

## 40. What are the best practices for using PARAMETERS?

**Answer:**

* Use Dictionary data elements whenever possible.
* Validate all user input.
* Keep parameter names meaningful.
* Group related fields into blocks.
* Use text symbols instead of hard-coded labels.
* Use `OBLIGATORY` only when necessary.
* Provide sensible default values.
* Keep the selection screen simple and user-friendly.
