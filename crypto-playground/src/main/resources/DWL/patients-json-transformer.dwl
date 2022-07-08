%dw 2.0
import * from dw::util::Values
import dw::Crypto
output application/json
---
//payload mask "ssn" with "***-##-***"
//payload mask field("ssn") with "***-##-***"
//payload mask "ssn" with ($ replace /^[0-9]{3}-[0-9]{2}/ with "***-**")
//"MD5" : Crypto::MD5("This is a test" as Binary)
//Crypto::hashWith("This is a test" as Binary,"SHA-256")
payload map {
    First_Name: $.first_name,
    Last_Name: $.last_name,
    Email_Address:$.email,
    SSN_Masked: $.ssn replace /^[0-9]{3}-[0-9]{2}/ with "***-**",
    SSN_Encrypted: Crypto::MD5($.ssn as Binary),
    Health_data: {
        NHS_Number_last_4Digit: $.health_data.nhs_number replace /^[0-9]{6}/ with "",
        Medicine_Encrypted: Crypto::hashWith($.health_data.drug_name as Binary,"SHA-256"),
    	Fda_Ndc_Code_Encrypted: Crypto::SHA1($.health_data.fda_ndc_code as Binary),
    	Drug_Company: $.health_data.drug_company
    }  
 
}
