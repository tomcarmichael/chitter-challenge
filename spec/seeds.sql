TRUNCATE TABLE users, peeps, tags RESTART IDENTITY;

INSERT INTO "public"."users" ("name", "username", "email", "password") VALUES
('Tom Carmichael-Mhanna', 'tcarmichael', 'tomcarmichael@hotmail.co.uk', 
'$2a$12$Uq6.MjwYOnRrReg8MER7k.tbst9C8endU7NsqbfPOcJrBv/Vjlaii'), --'  '
('Sarwah Mhanna', 'smhanna', 'sarwah_mhanna@hotmail.com', 
'$2a$12$EJbWANsMc/.jLPCm5rccYedi0PqM0qM4TP3UuJyi8I/oin2ctrQtm'), --'password456'
('Winston Smith', 'wsmith', 'orwell.george@aol.com',
'$2a$12$OAMZTYU7QDGVpgQIIYGdteqshFWf9LOuwWVw8RB.4NdX3yeHy.CPC'); --bigbrother

INSERT INTO "public"."peeps" ("message", "posted_at", "user_id") VALUES
('@wsmith & @smhanna - this is jam hot, this is jam hot', '2022-12-19 10:23:54', 1),
('Big Brother is watching you @wsmith', '2023-03-27 22:05:37', 2),
('We shall meet in the place where there is no darkness', '1984-06-15 14:33:00', 3);

INSERT INTO "public"."tags" ("peep_id", "user_id") VALUES
(1, 2),
(1, 3),
(2, 3);
