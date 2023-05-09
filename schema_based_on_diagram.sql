create database clinic;
\c clinic;

-- create tables
CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL
);

CREATE TABLE medical_histories (
    id SERIAL PRIMARY KEY,
    admitted_at TIMESTAMP NOT NULL,
    patient_id INT NOT NULL,
    status VARCHAR(255) NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE
);

CREATE TABLE invoices (
    id SERIAL PRIMARY KEY,
    total_amount DECIMAL(10,2) NOT NULL,
    generated_at TIMESTAMP NOT NULL,
    payed_at TIMESTAMP,
    medical_history_id INT NOT NULL,
    FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id) ON DELETE CASCADE
);

CREATE TABLE invoices_items (
    id SERIAL PRIMARY KEY,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    invoice_id INT NOT NULL,
    treatment_id INT NOT NULL,
    FOREIGN KEY (invoice_id) REFERENCES invoices(id) ON DELETE CASCADE,
    FOREIGN KEY (treatment_id) REFERENCES treatments(id) ON DELETE CASCADE
);

CREATE TABLE treatments (
    id SERIAL PRIMARY KEY,
    type VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE medical_histories_has_treatments (
    medical_history_id int REFERENCES medical_histories(id),
    treatment_id int REFERENCES treatments(id)
    );

CREATE INDEX ON medical_histories_has_treatments (medical_history_id);
CREATE INDEX ON medical_histories_has_treatments (treatment_id);
CREATE INDEX ON invoices_items (invoice_id);
CREATE INDEX ON invoices_items (treatment_id);
CREATE INDEX ON invoices (medical_history_id);

CREATE INDEX ON medical_histories (patient_id);
