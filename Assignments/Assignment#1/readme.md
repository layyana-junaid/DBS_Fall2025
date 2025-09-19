### Task 3 Outouts:

Table TESTS dropped.


Table INVOICE dropped.


Table PRESCRIPTION dropped.


Table APPOINTMENT dropped.


Table DOCTOR dropped.


Table PATIENT dropped.


Table PATIENT created.


Table DOCTOR created.


Table APPOINTMENT created.


Table PRESCRIPTION created.


Table INVOICE created.


Table TESTS created.


1 row inserted.


1 row inserted.


1 row inserted.


1 row inserted.


1 row inserted.


1 row inserted.


1 row inserted.


1 row inserted.


1 row inserted.


1 row inserted.


1 row inserted.


1 row inserted.


Commit complete.


1 row updated.


Commit complete.


1 row updated.


Commit complete.


1 row deleted.


Commit complete.


1 row deleted.


Commit complete.


APPOINTMENT_ID APPOINTME APPOINTMENT_TIME     STATUS               CLINIC_NUMBER        PATIENT_ID  DOCTOR_ID
-------------- --------- -------------------- -------------------- -------------------- ---------- ----------
           201 02-SEP-25 10:00 AM             Booked               C-01                          1        101

no rows selected

   TEST_ID BLOOD X_RAY MRI   CT_SC PATIENT_ID  DOCTOR_ID
---------- ----- ----- ----- ----- ---------- ----------
       501 Yes   No    No    No             1        101


PRESCRIPTION_ID PRESCRIPT DOCTOR_ADVICE                                                                                                                                                                                                                                                   F PATIENT_ID  DOCTOR_ID
--------------- --------- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- - ---------- ----------
            301 02-SEP-25 Take medicine twice daily                                                                                                                                                                                                                                       Y          1        101


PATIENT_NAME                                                                                         DOCTOR_NAME                                                                                          APPOINTME APPOINTMENT_TIME     STATUS              
---------------------------------------------------------------------------------------------------- ---------------------------------------------------------------------------------------------------- --------- -------------------- --------------------
Ali Khan                                                                                             Dr. Hamid                                                                                            02-SEP-25 10:00 AM             Booked              


PATIENT_NAME                                                                                         DOCTOR_NAME                                                                                             TEST_ID BLOOD X_RAY MRI   CT_SC
---------------------------------------------------------------------------------------------------- ---------------------------------------------------------------------------------------------------- ---------- ----- ----- ----- -----
Ali Khan                                                                                             Dr. Hamid                                                                                                   501 Yes   No    No    No   
Sara Ahmed                                                                                           Dr. Ayesha                                                                                                  502 No    Yes   No    No   


NAME                                                                                                 PRESCRIPTION_ID DOCTOR_ADVICE                                                                                                                                                                                                                                                   PRESCRIPT
---------------------------------------------------------------------------------------------------- --------------- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ---------
Ali Khan                                                                                                         301 Take medicine twice daily                                                                                                                                                                                                                                       02-SEP-25


PRESCRIPTION_ID DOCTOR_ADVICE                                                                                                                                                                                                                                                   PRESCRIPT PATIENT_NAME                                                                                         DOCTOR_NAME                                                                                         
--------------- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- --------- ---------------------------------------------------------------------------------------------------- ----------------------------------------------------------------------------------------------------
            301 Take medicine twice daily                                                                                                                                                                                                                                       02-SEP-25 Ali Khan                                                                                             Dr. Hamid                                                                                           


