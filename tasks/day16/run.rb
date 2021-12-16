module Tasks
  module Day16
    class Run
      def call1
        package = Package.build(input)

        package.version_sum
      end

      def call2
        package = Package.build(input)

        package.value
      end

      private

      def detect_version(input)
      end

      def input
        @input ||= Input.call
      end
    end
  end
end
