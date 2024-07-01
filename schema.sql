/*
Last Up 07-01-2024

4 tables:
- "users": Store user information including admins, lawyers, and staff.
- "cases": Store case information including client details and case status.
- "documents": Store document metadata linked to cases.
- "gratns": Store grant information linked to cases & documnets
*/

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY, -- ex) 1
    first_name VARCHAR(100) NOT NULL, -- ex) John
    middle_initial CHAR(1) NOT NULL, -- ex) A
    last_name VARCHAR(100) NOT NULL, -- ex) Doe
    email VARCHAR(100) UNIQUE NOT NULL, -- ex) abcde@example.com
    password VARCHAR(255) NOT NULL, -- ex) PWD12345
    role CHAR(6) NOT NULL, -- ex) "ADMIN_", "LAWYER", "STAFF_"
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- ex) 2024-07-01 00:00:00
);

CREATE TABLE cases (
    case_id_ibj SERIAL PRIMARY KEY, -- ex) 1
    country_code VARCHAR(6) NOT NULL, -- max 5 letters, ex) INDIA for India, USA for United States, CANADA for Canada
    case_id_national VARCHAR(50) UNIQUE NOT NULL, -- ex) DJEJ31235
    client_name VARCHAR(100) NOT NULL, -- ex) John Doe
    case_type VARCHAR(100) NOT NULL, -- ex) Civil
    status CHAR(8), -- ex) ACTIVE__, INACTIVE, CLOSED__
    assigned_lawyer INT REFERENCES users(user_id), -- ex) 1
    description TEXT, -- ex) This case is related to a civil dispute.
    grant_id INT REFERENCES grants(grant_id), -- ex) 2
    created_by INT REFERENCES users(user_id), -- ex) 1
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- ex) 2024-07-01 00:00:00
    updated_by INT REFERENCES users(user_id), -- ex) 1
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- ex) 2024-07-01 00:00:00
);

CREATE TABLE documents (
    doc_id SERIAL PRIMARY KEY, -- ex) 1
    case_id INT REFERENCES cases(case_id_ibj), -- ex) 1
    user_id INT REFERENCES users(user_id), -- ex) 1
    document_name VARCHAR(100), -- ex) LegalDocument.pdf
    document_path VARCHAR(255), -- ex) /path/to/document/LegalDocument.pdf
    uploaded_by INT REFERENCES users(user_id), -- ex) 1
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- ex) 2024-07-01 00:00:00
);

CREATE TABLE grants (
    grant_id SERIAL PRIMARY KEY, -- ex) 1
    grant_source VARCHAR(100) NOT NULL, -- ex) The British Council
    grant_type VARCHAR(100) NOT NULL, -- ex) Scholarship
    grant_amount DECIMAL(1000000000000000000000,2) NOT NULL, -- ex) 10000.00
    grant_status VARCHAR(50) NOT NULL, -- ex) APPROVED
    grant_description TEXT, -- ex) This grant is provided for legal aid.
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- ex) 2024-07-01 00:00:00
);
