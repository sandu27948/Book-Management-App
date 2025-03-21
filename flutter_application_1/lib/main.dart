import 'package:flutter/material.dart';

void main() {
  runApp(BookManagementApp());
}

class BookManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BookListScreen(),
    );
  }
}

class BookListScreen extends StatefulWidget {
  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  final List<Map<String, String>> _books = [];
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();

  void _addBook() {
    String id = _idController.text.trim();
    String title = _titleController.text.trim();
    String author = _authorController.text.trim();

    if (id.isNotEmpty && title.isNotEmpty && author.isNotEmpty) {
      setState(() {
        _books.insert(0, {'id': id, 'title': title, 'author': author}); // Insert at the beginning
      });

      // Clear input fields
      _idController.clear();
      _titleController.clear();
      _authorController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Management'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(_idController, 'Book ID', Icons.confirmation_number),
            SizedBox(height: 10),
            _buildTextField(_titleController, 'Book Name', Icons.book),
            SizedBox(height: 10),
            _buildTextField(_authorController, 'Author', Icons.person),
            SizedBox(height: 15),
            SizedBox(
              width: 200, // Set the desired width here
              child: ElevatedButton(
                onPressed: _addBook,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.blue,
                ),
                child: Text('Add Book', style: TextStyle(fontSize: 16)),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _books.isEmpty
                  ? Center(child: Text('No books added yet', style: TextStyle(fontSize: 16)))
                  : ListView.builder(
                      itemCount: _books.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 4,
                          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Text(_books[index]['id']!, style: TextStyle(color: Colors.white)),
                            ),
                            title: Text(
                              _books[index]['title']!,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            subtitle: Text(
                              'Author: ${_books[index]['author']}',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blue),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}