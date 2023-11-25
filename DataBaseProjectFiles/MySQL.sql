CREATE TABLE `users` (
  `u_id` integer PRIMARY KEY,
  `name` text NOT NULL,
  `mobile` text NOT NULL,
  `wallet_id` integer NOT NULL,
  `when_created` timestamp NOT NULL
);

CREATE TABLE `transfers` (
  `transfer_id` integer PRIMARY KEY,
  `u_id` integer NOT NULL,
  `source_wallet_id` integer NOT NULL,
  `dest_wallet_id` integer NOT NULL,
  `send_amount_currency` text NOT NULL,
  `send_amount_scalar` numeric NOT NULL,
  `receive_amount_currency` text NOT NULL,
  `receive_amount_scalar` numeric NOT NULL,
  `kind` text NOT NULL,
  `dest_mobile` text,
  `dest_merchant_id` integer,
  `when_created` timestamp NOT NULL
);

CREATE TABLE `agents` (
  `agent_id` integer PRIMARY KEY,
  `name` text,
  `country` text NOT NULL,
  `region` text,
  `city` text,
  `subcity` text,
  `when_created` timestamp NOT NULL
);

CREATE TABLE `agent_transactions` (
  `atx_id` integer PRIMARY KEY,
  `u_id` integer NOT NULL,
  `agent_id` integer NOT NULL,
  `amount` numeric NOT NULL,
  `fee_amount_scalar` numeric NOT NULL,
  `when_created` timestamp NOT NULL
);

CREATE TABLE `wallets` (
  `wallet_id` integer PRIMARY KEY,
  `currency` text NOT NULL,
  `ledger_location` text NOT NULL,
  `when_created` timestamp NOT NULL
);

ALTER TABLE `transfers` ADD FOREIGN KEY (`u_id`) REFERENCES `users` (`u_id`);

ALTER TABLE `agent_transactions` ADD FOREIGN KEY (`agent_id`) REFERENCES `agents` (`agent_id`);

ALTER TABLE `users` ADD FOREIGN KEY (`u_id`) REFERENCES `agent_transactions` (`u_id`);

ALTER TABLE `transfers` ADD FOREIGN KEY (`source_wallet_id`) REFERENCES `wallets` (`wallet_id`);

ALTER TABLE `transfers` ADD FOREIGN KEY (`dest_wallet_id`) REFERENCES `wallets` (`wallet_id`);

ALTER TABLE `wallets` ADD FOREIGN KEY (`wallet_id`) REFERENCES `users` (`wallet_id`);
