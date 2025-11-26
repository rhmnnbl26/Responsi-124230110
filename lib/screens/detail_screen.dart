import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/article_model.dart';
import '../services/favorite_service.dart';

class DetailScreen extends StatefulWidget {
  final Article article;

  const DetailScreen({super.key, required this.article});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final FavoriteService _favoriteService = FavoriteService();
  bool _isFavorite = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    final isFavorite = await _favoriteService.isFavorited(widget.article);
    setState(() {
      _isFavorite = isFavorite;
      _isLoading = false;
    });
  }

  Future<void> _toggleFavorite() async {
    final newStatus = await _favoriteService.toggleFavorite(widget.article);

    setState(() {
      _isFavorite = newStatus;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            newStatus
                ? '${widget.article.title} ditambahkan ke favorit'
                : '${widget.article.title} dihapus dari favorit',
          ),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _openUrl() async {
    final Uri url = Uri.parse(widget.article.url);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Could not open URL')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
        backgroundColor: Colors.red[700],
        foregroundColor: Colors.white,
        actions: [
          _isLoading
              ? const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ),
                )
              : IconButton(
                  icon: Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                  ),
                  onPressed: _toggleFavorite,
                  iconSize: 28,
                ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [_buildHeader(), _buildDetailSection()],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openUrl,
        backgroundColor: Colors.red[700],
        foregroundColor: Colors.white,
        icon: const Icon(Icons.language),
        label: const Text('Open Article'),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.red[700]!, Colors.red[400]!],
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),

          if (widget.article.imageUrl.isNotEmpty)
            CachedNetworkImage(
              imageUrl: widget.article.imageUrl,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                height: 250,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(color: Colors.white),
              ),
              errorWidget: (context, url, error) => Container(
                height: 250,
                alignment: Alignment.center,
                child: const Icon(Icons.error, size: 64, color: Colors.white),
              ),
            ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              widget.article.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildDetailSection() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Informasi Detail',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          _buildDetailItem(
            icon: Icons.language,
            title: 'News Site',
            value: widget.article.newsSite,
            color: Colors.blue,
          ),

          const SizedBox(height: 16),

          _buildDetailItem(
            icon: Icons.description,
            title: 'Summary',
            value: widget.article.summary,
            color: Colors.orange,
          ),

          const SizedBox(height: 16),

          _buildDetailItem(
            icon: Icons.calendar_today,
            title: 'Published At',
            value: _formatDate(widget.article.publishedAt),
            color: Colors.green,
          ),

          const SizedBox(height: 16),

          _buildDetailItem(
            icon: Icons.star,
            title: 'Featured',
            value: widget.article.featured ? 'Yes' : 'No',
            color: Colors.purple,
          ),

          const SizedBox(height: 32),

          Center(
            child: ElevatedButton.icon(
              onPressed: _toggleFavorite,
              icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border),
              label: Text(
                _isFavorite ? 'Hapus dari Favorit' : 'Tambah ke Favorit',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _isFavorite
                    ? Colors.grey[700]
                    : Colors.red[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),

          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 24),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateStr;
    }
  }
}
