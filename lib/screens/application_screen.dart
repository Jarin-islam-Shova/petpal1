import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdoptionApplicationsScreen extends StatefulWidget {
  const AdoptionApplicationsScreen({Key? key}) : super(key: key);

  @override
  State<AdoptionApplicationsScreen> createState() =>
      _AdoptionApplicationsScreenState();
}

class _AdoptionApplicationsScreenState extends State<AdoptionApplicationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Application> _applications = [
    Application(
      id: '1',
      petName: 'Max',
      petType: 'Dog',
      breed: 'Golden Retriever',
      status: ApplicationStatus.pending,
      submittedDate: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Application(
      id: '2',
      petName: 'Luna',
      petType: 'Cat',
      breed: 'Persian',
      status: ApplicationStatus.approved,
      submittedDate: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Application(
      id: '3',
      petName: 'Rocky',
      petType: 'Dog',
      breed: 'German Shepherd',
      status: ApplicationStatus.rejected,
      submittedDate: DateTime.now().subtract(const Duration(days: 7)),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Applications'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Pending'),
            Tab(text: 'Approved'),
            Tab(text: 'Rejected'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildApplicationList(ApplicationStatus.pending),
          _buildApplicationList(ApplicationStatus.approved),
          _buildApplicationList(ApplicationStatus.rejected),
        ],
      ),
    );
  }

  Widget _buildApplicationList(ApplicationStatus status) {
    final filteredApplications = _applications
        .where((application) => application.status == status)
        .toList();

    if (filteredApplications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.clipboard,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No ${status.name} applications',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredApplications.length,
      itemBuilder: (context, index) {
        return ApplicationCard(application: filteredApplications[index]);
      },
    );
  }
}

class ApplicationCard extends StatelessWidget {
  final Application application;

  const ApplicationCard({
    Key? key,
    required this.application,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  child: Icon(
                    application.petType == 'Dog'
                        ? FontAwesomeIcons.dog
                        : FontAwesomeIcons.cat,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        application.petName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${application.petType} • ${application.breed}',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                _buildStatusChip(context),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Submitted on ${_formatDate(application.submittedDate)}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // TODO: Show application details
                  },
                  child: const Text('View Details'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    String text = application.status.name[0].toUpperCase() +
        application.status.name.substring(1);

    switch (application.status) {
      case ApplicationStatus.pending:
        backgroundColor = Colors.orange[100]!;
        textColor = Colors.orange[900]!;
        break;
      case ApplicationStatus.approved:
        backgroundColor = Colors.green[100]!;
        textColor = Colors.green[900]!;
        break;
      case ApplicationStatus.rejected:
        backgroundColor = Colors.red[100]!;
        textColor = Colors.red[900]!;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

enum ApplicationStatus {
  pending,
  approved,
  rejected,
}

class Application {
  final String id;
  final String petName;
  final String petType;
  final String breed;
  final ApplicationStatus status;
  final DateTime submittedDate;

  Application({
    required this.id,
    required this.petName,
    required this.petType,
    required this.breed,
    required this.status,
    required this.submittedDate,
  });
}
