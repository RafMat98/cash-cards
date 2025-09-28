-- Initial data for production PostgreSQL database
INSERT INTO cash_card(amount, owner) VALUES (123.45, 'sarah1') ON CONFLICT DO NOTHING;
INSERT INTO cash_card(amount, owner) VALUES (1.00, 'sarah1') ON CONFLICT DO NOTHING;
INSERT INTO cash_card(amount, owner) VALUES (150.00, 'sarah1') ON CONFLICT DO NOTHING;
INSERT INTO cash_card(amount, owner) VALUES (200.00, 'kumar2') ON CONFLICT DO NOTHING;