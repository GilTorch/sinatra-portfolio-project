require './config/environment'

use Rack::MethodOverride
# use Rack::Session::Cookie

use SessionsController
use UsersController
use TheAdminsController
use CoursesController
run ApplicationController