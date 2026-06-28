# Interview Questions - ZSS_10_FILE_UPLOAD

This document contains frequently asked SAP ABAP interview questions related to **File Upload**, **Frontend Services**, **File Selection Dialog**, and **Reading Files from the Presentation Server**. The questions are categorized from beginner to advanced level, including real-time scenarios and tricky interview questions commonly asked in SAP ABAP interviews.

---

# Beginner Level

## 1. What is File Upload in SAP ABAP?

**Answer:**

File Upload is the process of selecting and reading a file from the user's local computer (Presentation Server) into an SAP program for further processing.

---

## 2. Why do we use File Upload in SAP ABAP?

**Answer:**

File Upload is commonly used for:

- Master Data Upload
- Transaction Data Upload
- Data Migration
- Excel Upload
- CSV Upload
- Bulk Data Processing
- Interface Programs

---

## 3. Which event is used to implement File Browse (F4 Help)?

**Answer:**

```abap
AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.
```

---

## 4. Which class is commonly used for File Upload?

**Answer:**

```text
CL_GUI_FRONTEND_SERVICES
```

---

## 5. Which method opens the File Selection Dialog?

**Answer:**

```text
FILE_OPEN_DIALOG
```

---

## 6. Which method checks whether a file exists?

**Answer:**

```text
FILE_EXIST
```

---

## 7. What is a Presentation Server?

**Answer:**

The Presentation Server is the user's local computer where SAP GUI is running.

---

## 8. What is an Application Server?

**Answer:**

The Application Server is the SAP server where SAP programs execute.

---

## 9. Can File Upload read Excel files?

**Answer:**

Yes.

Common formats include:

- XLS
- XLSX
- CSV
- TXT

---

## 10. Why should users browse for files instead of typing the path manually?

**Answer:**

Browsing reduces typing mistakes and ensures a valid file path is selected.

---

# Intermediate Level

## 11. Which method is used to open the Windows File Browser?

**Answer:**

```abap
CL_GUI_FRONTEND_SERVICES=>FILE_OPEN_DIALOG
```

---

## 12. Which method verifies whether the selected file exists?

**Answer:**

```abap
CL_GUI_FRONTEND_SERVICES=>FILE_EXIST
```

---

## 13. Which Function Module is traditionally used for file upload?

**Answer:**

```text
GUI_UPLOAD
```

Although older, it is still used in many legacy programs.

---

## 14. Which class is preferred in modern ABAP development?

**Answer:**

```text
CL_GUI_FRONTEND_SERVICES
```

---

## 15. Can file type filters be applied?

**Answer:**

Yes.

Example:

- *.csv
- *.txt
- *.xlsx

---

## 16. Can users cancel the File Dialog?

**Answer:**

Yes.

The program should handle user cancellation gracefully.

---

## 17. Can File Upload be used on the Selection Screen?

**Answer:**

Yes.

It is commonly implemented using:

```abap
AT SELECTION-SCREEN ON VALUE-REQUEST.
```

---

## 18. Should file existence be checked before reading?

**Answer:**

Yes.

Always verify that the selected file exists before processing.

---

## 19. Can uploaded files be validated?

**Answer:**

Yes.

Typical validations include:

- File exists
- Correct extension
- Correct format
- File size
- Mandatory columns

---

## 20. Can File Upload display custom error messages?

**Answer:**

Yes.

Meaningful error messages should be displayed whenever validation fails.

---

# Advanced Level

## 21. What is the difference between Presentation Server and Application Server Upload?

**Answer:**

| Presentation Server | Application Server |
|---------------------|-------------------|
| User's Local PC | SAP Server |
| Uses GUI_UPLOAD or Frontend Services | Uses OPEN DATASET |
| Requires SAP GUI | Runs on SAP Server |

---

## 22. What is the difference between GUI_UPLOAD and OPEN DATASET?

**Answer:**

### GUI_UPLOAD

- Reads files from the local computer.
- Requires SAP GUI.

### OPEN DATASET

- Reads files stored on the SAP Application Server.
- Does not require SAP GUI.

---

## 23. Why is CL_GUI_FRONTEND_SERVICES preferred?

**Answer:**

Because it is object-oriented, modern, and provides many frontend utilities such as file dialogs and file existence checks.

---

## 24. Can File Upload support drag-and-drop?

**Answer:**

Not directly on the standard Selection Screen.

Custom GUI applications can provide drag-and-drop functionality.

---

## 25. Can uploaded files be converted into internal tables?

**Answer:**

Yes.

This is the most common processing step after selecting a file.

---

## 26. Can large files be uploaded?

**Answer:**

Yes.

However, performance and memory usage should be considered.

---

## 27. How should upload errors be handled?

**Answer:**

Using proper exception handling and meaningful messages for scenarios such as:

- File not found
- Invalid format
- Permission denied
- Empty file

---

## 28. Can only specific file extensions be allowed?

**Answer:**

Yes.

The File Dialog can be configured to allow only selected file types.

---

## 29. Can uploaded data be validated before database updates?

**Answer:**

Yes.

Validation should always be performed before inserting or updating SAP tables.

---

## 30. Why is File Upload considered a common real-time requirement?

**Answer:**

Because businesses frequently upload master data, transaction data, pricing information, and migration files into SAP.

---

# Scenario-Based Questions

## 31. Users need to upload a Material Master Excel file. How would you implement it?

**Answer:**

- Browse the file using `FILE_OPEN_DIALOG`
- Validate the file path
- Check that the file exists
- Read the file into an internal table
- Validate the data
- Update SAP using BAPI or direct database logic (where appropriate)

---

## 32. Users accidentally select a PDF instead of an Excel file. What should happen?

**Answer:**

Validate the file extension and display an error message indicating that only supported file types are allowed.

---

## 33. The selected file does not exist. What should the program do?

**Answer:**

Use `FILE_EXIST` to verify the file and display an error if it cannot be found.

---

## 34. Users should upload only CSV files. How would you implement this?

**Answer:**

Configure the File Dialog filter to show only `*.csv` files and validate the selected extension before processing.

---

## 35. The upload file contains duplicate records. How would you handle it?

**Answer:**

Read the data into an internal table, identify duplicate entries, inform the user, and process only valid records according to business requirements.

---

## 36. Users cancel the File Dialog without selecting a file. What should happen?

**Answer:**

The program should detect the cancellation, leave the file parameter unchanged, and avoid unnecessary processing.

---

## 37. The uploaded file contains mandatory columns that are missing. What should you do?

**Answer:**

Validate the file structure before processing and display an appropriate error message.

---

## 38. The file contains 100,000 records. What should you consider?

**Answer:**

- Performance
- Memory usage
- Batch processing
- Package processing
- Efficient internal table handling

---

## 39. Why should uploaded data be validated before database updates?

**Answer:**

To prevent incorrect or inconsistent data from being stored in SAP.

---

## 40. Why should users browse instead of typing file paths?

**Answer:**

Browsing reduces typing mistakes, improves usability, and ensures the selected file actually exists.

---

# Real-Time Project Questions

## 41. Where have you implemented File Upload in your project?

**Answer:**

Examples:

- Material Master Upload
- Customer Master Upload
- Vendor Master Upload
- Pricing Upload
- Sales Order Upload
- Purchase Order Upload
- Employee Data Upload
- Bank Data Upload

---

## 42. Which class have you used for File Selection?

**Answer:**

```text
CL_GUI_FRONTEND_SERVICES
```

---

## 43. Which method have you used most frequently?

**Answer:**

```text
FILE_OPEN_DIALOG
```

---

## 44. Which validations did you implement before processing uploaded files?

**Answer:**

- File selected
- File exists
- Valid extension
- Correct format
- Mandatory columns
- Duplicate record checks
- Business rule validations

---

## 45. Why is File Upload important in SAP projects?

**Answer:**

It enables efficient bulk data processing, simplifies migration activities, reduces manual data entry, and improves productivity.

---

# Rapid Fire Questions

### 46. Which event is used for File Browse?

**Answer:** `AT SELECTION-SCREEN ON VALUE-REQUEST`

---

### 47. Which class provides File Dialog functionality?

**Answer:** `CL_GUI_FRONTEND_SERVICES`

---

### 48. Which method opens the File Browser?

**Answer:** `FILE_OPEN_DIALOG`

---

### 49. Which method checks whether a file exists?

**Answer:** `FILE_EXIST`

---

### 50. Which Function Module uploads files from the Presentation Server?

**Answer:** `GUI_UPLOAD`

---

### 51. Which statement reads files from the Application Server?

**Answer:** `OPEN DATASET`

---

### 52. Where is the Presentation Server?

**Answer:** User's local computer.

---

### 53. Where is the Application Server?

**Answer:** SAP Server.

---

### 54. Can File Upload support Excel files?

**Answer:** Yes.

---

### 55. Should uploaded files be validated?

**Answer:** Yes.

---

# Tricky Interview Questions

## 56. What is the difference between `GUI_UPLOAD` and `CL_GUI_FRONTEND_SERVICES`?

**Answer:**

- `GUI_UPLOAD` is a **Function Module** used to upload files from the Presentation Server.
- `CL_GUI_FRONTEND_SERVICES` is an **Object-Oriented SAP class** that provides frontend services such as file browsing, file existence checks, and other GUI-related operations. Modern ABAP development generally prefers this class.

---

## 57. What is the difference between `FILE_OPEN_DIALOG` and `FILE_EXIST`?

**Answer:**

- `FILE_OPEN_DIALOG` allows the user to browse and select a file.
- `FILE_EXIST` checks whether the selected file actually exists before processing.

---

## 58. Can `FILE_OPEN_DIALOG` read the contents of a file?

**Answer:**

No.

It only allows the user to select a file and returns its path. A separate step (such as `GUI_UPLOAD` or another file-reading mechanism) is required to read the file contents.

---

## 59. Why shouldn't a program directly process a selected file without validation?

**Answer:**

Because the selected file may:

- Not exist
- Have the wrong format
- Contain invalid or incomplete data
- Be empty
- Have an unsupported extension

Proper validation prevents runtime errors and incorrect data processing.

---

## 60. Which approach is recommended in modern SAP ABAP development: using legacy Function Modules or object-oriented frontend services?

**Answer:**

For **file selection and frontend interaction**, the recommended approach is to use **`CL_GUI_FRONTEND_SERVICES`** because it follows object-oriented principles and provides a richer, more maintainable API. Legacy function modules like `GUI_UPLOAD` are still encountered in existing systems but are generally used only when required for compatibility with older implementations.