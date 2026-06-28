# Interview Questions - ZSS_02_SELECT_OPTIONS

This document contains frequently asked SAP ABAP interview questions related to the **SELECT-OPTIONS** statement. The questions are categorized from beginner to advanced level, including real-time scenarios and tricky interview questions commonly asked in SAP ABAP interviews.

---

# Beginner Level

## 1. What is SELECT-OPTIONS in SAP ABAP?

**Answer:**

`SELECT-OPTIONS` is a selection screen statement used to accept **single values, multiple values, intervals (ranges), and exclusion values** from the user.

Example:

```abap
SELECT-OPTIONS: s_matnr FOR mara-matnr.
```

---

## 2. Why do we use SELECT-OPTIONS?

**Answer:**

We use `SELECT-OPTIONS` whenever users need flexibility to enter:

- Single value
- Multiple values
- Value ranges
- Excluded values

---

## 3. What is the difference between PARAMETERS and SELECT-OPTIONS?

| PARAMETERS | SELECT-OPTIONS |
|------------|----------------|
| Accepts only one value | Accepts multiple values |
| No intervals | Supports intervals |
| No exclusion | Supports exclusion |
| Simple input field | Creates an internal selection table |

---

## 4. What type of object does SELECT-OPTIONS create?

**Answer:**

It creates an **internal table** with the following structure:

- SIGN
- OPTION
- LOW
- HIGH

---

## 5. What are the four fields of a SELECT-OPTIONS internal table?

**Answer:**

- SIGN
- OPTION
- LOW
- HIGH

---

## 6. What is the purpose of LOW?

**Answer:**

LOW stores the starting value or single value entered by the user.

---

## 7. What is the purpose of HIGH?

**Answer:**

HIGH stores the ending value when a range is entered.

---

## 8. Can SELECT-OPTIONS accept a single value?

**Answer:**

Yes.

Even if only one value is entered, it is stored in the selection table.

---

## 9. Can users enter multiple values?

**Answer:**

Yes.

Users can click the Multiple Selection button and enter multiple values.

---

## 10. Can users enter ranges?

**Answer:**

Yes.

Example:

```
1000 - 2000
```

---

# Intermediate Level

## 11. What is SIGN?

**Answer:**

SIGN determines whether values should be included or excluded.

Possible values:

- I → Include
- E → Exclude

---

## 12. What is OPTION?

**Answer:**

OPTION specifies the comparison operator.

Examples:

- EQ
- NE
- GT
- LT
- GE
- LE
- BT
- NB
- CP
- NP

---

## 13. What does OPTION = EQ mean?

**Answer:**

Equal to.

Example:

```
Material = MAT100
```

---

## 14. What does OPTION = BT mean?

**Answer:**

Between.

Example:

```
1000 to 5000
```

---

## 15. What does OPTION = CP mean?

**Answer:**

Contains Pattern.

Example:

```
AB*
```

---

## 16. What is the difference between Include and Exclude?

**Answer:**

Include

```
SIGN = I
```

means include matching values.

Exclude

```
SIGN = E
```

means remove matching values.

---

## 17. Can default values be assigned?

**Answer:**

Yes.

Usually in the `INITIALIZATION` event.

Example:

```abap
INITIALIZATION.

s_matnr-sign = 'I'.
s_matnr-option = 'EQ'.
s_matnr-low = 'MAT100'.

APPEND s_matnr.
```

---

## 18. Which event is commonly used to validate SELECT-OPTIONS?

**Answer:**

```
AT SELECTION-SCREEN.
```

or

```
AT SELECTION-SCREEN ON s_matnr.
```

---

## 19. Can F4 Help be used with SELECT-OPTIONS?

**Answer:**

Yes.

Standard SAP Search Help is available automatically when using Dictionary fields.

Custom F4 Help can be implemented using:

```abap
AT SELECTION-SCREEN
ON VALUE-REQUEST FOR s_matnr-low.
```

---

## 20. How do you process SELECT-OPTIONS values?

**Answer:**

Using

```abap
LOOP AT s_matnr.
```

---

# Advanced Level

## 21. What is the internal type of SELECT-OPTIONS?

**Answer:**

A Range Table.

Structure:

- SIGN
- OPTION
- LOW
- HIGH

---

## 22. What is a Range Table?

**Answer:**

A standard internal table with the fields:

- SIGN
- OPTION
- LOW
- HIGH

used for dynamic filtering.

---

## 23. How can you read the first entered value?

**Answer:**

```abap
READ TABLE s_matnr INDEX 1.
```

---

## 24. How do you clear all entered values?

**Answer:**

```abap
CLEAR s_matnr.

REFRESH s_matnr.
```

---

## 25. Can SELECT-OPTIONS be hidden dynamically?

**Answer:**

Yes.

Using:

- MODIF ID
- LOOP AT SCREEN
- MODIFY SCREEN

---

## 26. Can SELECT-OPTIONS be disabled?

**Answer:**

Yes.

Using

```abap
SCREEN-INPUT = 0.
```

---

## 27. Can multiple SELECT-OPTIONS be grouped?

**Answer:**

Yes.

Using Selection Screen Blocks.

---

## 28. Can SELECT-OPTIONS use Search Helps?

**Answer:**

Yes.

Standard Search Help

Custom Search Help

Custom F4 Help

---

## 29. How does SELECT-OPTIONS work in Open SQL?

Example:

```abap
SELECT *
FROM mara
INTO TABLE lt_mara
WHERE matnr IN s_matnr.
```

---

## 30. Why is WHERE IN preferred over LOOP validation?

**Answer:**

Because filtering is done at the database level, which improves performance.

---

# Scenario-Based Questions

## 31. Users need to enter multiple Sales Orders. Which statement would you use?

**Answer:**

SELECT-OPTIONS

---

## 32. Users need to enter only one Company Code. Which statement is appropriate?

**Answer:**

PARAMETERS

---

## 33. Users want to exclude one Material from the report. How is this achieved?

**Answer:**

Use:

```
SIGN = E
```

---

## 34. A user enters a range of customer numbers. How is it stored?

**Answer:**

```
LOW

HIGH

OPTION = BT

SIGN = I
```

---

## 35. Where should SELECT-OPTIONS be validated?

**Answer:**

```
AT SELECTION-SCREEN.
```

---

## 36. Users want search help for Material Number. What should you do?

**Answer:**

Use a Dictionary field.

Example:

```abap
SELECT-OPTIONS:

s_matnr FOR mara-matnr.
```

---

## 37. Users entered 50 Material Numbers. How do you use them in SQL?

**Answer:**

```abap
WHERE matnr IN s_matnr.
```

---

## 38. A report should allow entering Plant ranges. Which statement is best?

**Answer:**

SELECT-OPTIONS

---

## 39. Users want to include Plants 1000–2000 but exclude Plant 1500. Can SELECT-OPTIONS handle this?

**Answer:**

Yes.

Use:

- Include range (1000–2000)
- Exclude single value (1500)

---

## 40. Why do SAP standard reports mostly use SELECT-OPTIONS?

**Answer:**

Because they provide maximum flexibility with minimal code.

---

# Real-Time Project Questions

## 41. In your project, where did you use SELECT-OPTIONS?

**Answer:**

In reports such as:

- Sales Order Report
- Customer Outstanding Report
- Delivery Report
- Billing Report
- Purchase Order Report

to allow users to filter data by multiple criteria.

---

## 42. Which fields commonly use SELECT-OPTIONS in an SD report?

**Answer:**

- Sales Order
- Customer
- Material
- Sales Organization
- Plant
- Billing Date
- Delivery Date

---

## 43. Why do business users prefer SELECT-OPTIONS over PARAMETERS?

**Answer:**

Because they can filter data using multiple values and ranges without executing the report repeatedly.

---

## 44. How do you improve report performance when using SELECT-OPTIONS?

**Answer:**

- Use `WHERE field IN s_field`.
- Avoid filtering in ABAP loops.
- Select only required fields.
- Use proper database indexes.

---

## 45. Have you used SELECT-OPTIONS with ALV reports?

**Answer:**

Yes. Selection criteria entered by the user are passed directly to the database query before displaying the ALV output.

---

# Rapid Fire Questions

### 46. Which statement supports ranges?

**Answer:** SELECT-OPTIONS

---

### 47. Which statement supports multiple values?

**Answer:** SELECT-OPTIONS

---

### 48. Which statement creates an internal table?

**Answer:** SELECT-OPTIONS

---

### 49. Which keyword is used in SQL with SELECT-OPTIONS?

**Answer:** `IN`

---

### 50. What are the four fields of a range table?

**Answer:**

- SIGN
- OPTION
- LOW
- HIGH

---

### 51. Which SIGN value means Include?

**Answer:** I

---

### 52. Which SIGN value means Exclude?

**Answer:** E

---

### 53. Which OPTION means Between?

**Answer:** BT

---

### 54. Which OPTION means Equal?

**Answer:** EQ

---

### 55. Which OPTION means Contains Pattern?

**Answer:** CP

---

# Tricky Interview Questions

## 56. Does SELECT-OPTIONS create only one field on the Selection Screen?

**Answer:**

No.

It creates:

- LOW field
- HIGH field (for ranges)
- Multiple Selection button

---

## 57. Can HIGH remain empty?

**Answer:**

Yes.

For single values, HIGH is empty.

---

## 58. What happens if a user enters only LOW?

**Answer:**

SAP treats it as a single value selection.

---

## 59. Can SELECT-OPTIONS be declared using a local variable?

**Answer:**

No.

It must reference a Dictionary field, data object, or compatible type.

---

## 60. Which is faster: filtering in SQL using `WHERE ... IN s_matnr` or selecting all records and filtering in ABAP?

**Answer:**

Filtering in SQL using `WHERE ... IN s_matnr` is much faster because the database performs the filtering, reducing memory usage and improving performance.

---
```