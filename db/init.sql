CREATE TABLE IF NOT EXISTS public.iridium
(
    "received_message" text COLLATE pg_catalog."default",
    reception_datetime timestamp with time zone DEFAULT timezone('America/Sao_Paulo', now())
    );
INSERT INTO public.vozes ("received_message","reception_datetime") VALUES ('teste','10/11/2023');