Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, '744444716406-i96vaelj3bln6r24i9evqs339osuhpmc.apps.googleusercontent.com', '7iGGnnzmxoXOgwqzK67wfo5r',{client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end
