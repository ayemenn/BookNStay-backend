
set :rails_env, "production"
# Define server roles
server "13.60.208.129", user: "ec2-user", roles: %w{app db web}
