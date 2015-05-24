class Application
  property port
  property name
  property verbose

  def initialize(name= __FILE__, @port=8080)
    @name ||= File.basename(name).gsub(/.\w+\Z/, "")
    @run_string = "[Amethyst #{Time.now}] serving application \"#{@name}\" at http://127.0.0.1:#{port}" #TODO move to Logger class
    @middleware_stack = MiddlewareStack.new 
  end

  def add_middleware(middleware : Middleware)
    @middleware_stack.add(middleware)
  end

  def serve()
    puts @run_string if @verbose
    server = HTTP::Server.new @port, BaseHandler.new(@middleware_stack)
    server.listen
  end
end