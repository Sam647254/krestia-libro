module KrestiaLibro
   def topic(title : String): TopicBuilder
      t = TopicBuilder.new title
      with t yield
      t
   end

   class TopicBuilder
      getter buffer
      getter title

      def initialize(@title : String)
         @buffer = IO::Memory.new
         @buffer << "# " << title << "\n\n"
      end

      def paragraph
         yield
         @buffer << "\n\n"
      end

      def text(t : String)
         @buffer << t
      end

      def save(output : IO)
         output.write @buffer.to_slice
      end
   end
end