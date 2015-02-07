module Tori
  module Backend
    class FileSystem
      attr_accessor :root
      def initialize(root)
        @root = root
        FileUtils.mkdir_p @root.to_s
      end

      def write(filename, resource)
        case resource
        when String
          ::File.open(path(filename), 'w'){ |f| f.write resource }
        else
          ::IO.copy_stream resource, path(filename)
        end
      end

      def delete(filename)
        ::File.unlink path(filename)
      end

      def exist?(filename)
        ::File.exist? path(filename)
      end
      alias exists? exist?

      def read(filename)
        ::File.read path(filename)
      end

      def path(filename)
        @root.join filename.to_s
      end
    end
  end
end
