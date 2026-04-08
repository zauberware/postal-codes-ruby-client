# PostalCodesClient

Ruby-Client-Gem für die PLZ API – Postleitzahlen-Suche über 100+ Länder.

## Installation

```ruby
# Gemfile
gem "postal_codes_client", path: "../postal_codes_client"
```

Oder als lokales Gem:

```bash
cd postal_codes_client
gem build postal_codes_client.gemspec
gem install postal_codes_client-0.1.0.gem
```

## Konfiguration

```ruby
require "postal_codes_client"

PostalCodesClient.configure do |config|
  config.base_url  = "http://localhost:3000"  # Standard
  config.api_token = "dein_api_token"
  config.timeout   = 30                       # Sekunden (Standard)
end
```

## Verwendung

### Client erstellen

```ruby
# Globale Konfiguration nutzen
client = PostalCodesClient::Client.new

# Oder Token direkt übergeben
client = PostalCodesClient::Client.new(
  api_token: "dein_api_token",
  base_url: "https://api.example.com"
)
```

### Authentifizierung

```ruby
# Registrierung
result = client.auth.signup(
  email: "user@example.com",
  password: "geheim123",
  password_confirmation: "geheim123",
  name: "Max Mustermann"
)
puts result[:api_token]

# Login
result = client.auth.login(email: "user@example.com", password: "geheim123")
client.api_token = result[:api_token]

# Profil abrufen
me = client.auth.me
puts me[:user][:email]

# Token erneuern
new_token = client.auth.regenerate_token
client.api_token = new_token[:api_token]
```

### Postleitzahlen suchen

```ruby
# PLZ-Suche (Teilsuche möglich)
results = client.postal_codes.search(q: "803", country: "DE")
results[:results].each do |pc|
  puts "#{pc[:zipcode]} #{pc[:place]} (#{pc[:state]})"
end

# Suche ohne Länderfilter
results = client.postal_codes.search(q: "1010", limit: 10)

# Verfügbare Länder auflisten
countries = client.postal_codes.countries
puts countries[:countries].join(", ")
```

### Fehlerbehandlung

```ruby
begin
  client.postal_codes.search(q: "803")
rescue PostalCodesClient::AuthenticationError => e
  puts "Nicht autorisiert: #{e.message}"
rescue PostalCodesClient::ValidationError => e
  puts "Validierungsfehler: #{e.errors.join(', ')}"
rescue PostalCodesClient::ApiError => e
  puts "API-Fehler (#{e.status}): #{e.message}"
rescue PostalCodesClient::Error => e
  puts "Fehler: #{e.message}"
end
```

## API-Referenz

| Methode | Beschreibung |
|---------|-------------|
| `client.auth.signup(email:, password:, password_confirmation:, name:)` | Registrierung |
| `client.auth.login(email:, password:)` | Login |
| `client.auth.regenerate_token` | Token erneuern |
| `client.auth.me` | Eigenes Profil |
| `client.postal_codes.search(q:, country:, limit:)` | PLZ-Suche |
| `client.postal_codes.countries` | Verfügbare Länder |
