require './config/environment'

use Rack::MethodOverride

use SessionsController
use UsersController

run ApplicationController