local status_ok, todo_comments = pcall(require, "todo-comments")

if not status_ok then
   vim.schedule(function()
      print("Error requiring todo_comments plugin.")
   end)

   return
end

todo_comments.setup()
