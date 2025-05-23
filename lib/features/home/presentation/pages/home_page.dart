import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:floy/floy.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zoncan/config/src/constants/app_constants.dart';
import 'package:zoncan/core/common/common.dart' show UnsupportedSizeScreen;
import 'package:zoncan/features/home/presentation/views/home_view.dart';
import 'package:zoncan/features/home/presentation/widgets/side_panel_header.dart';

class HomePage extends StatelessWidget {
  final Widget child;

  const HomePage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FloyResponsive(
        largePage: HomeView(child: child),
        xLargePage: HomeView(child: child),
        xxLargePage: HomeView(child: child),
        unsupportedSizePage: const UnsupportedSizeScreen(),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Side Navigation

          // Main Content
          Expanded(
            child: Column(
              children: [
                // Top Header

                // Dashboard Content
                Expanded(child: DashboardContent()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
//  MenuItemWidget(
//           icon: Icons.dashboard,
//           title: 'Dashboard',
//           isSelected: false,
//         ),
//         MenuItemWidget(
//           icon: Icons.account_balance_wallet,
//           title: 'Accounting Dashboard',
//           isSelected: true,
//         ),
//         MenuItemWidget(
//           icon: Icons.task,
//           title: 'Tasks Dashboard',
//           isSelected: false,
//         ),
//         MenuItemWidget(
//           icon: Icons.business,
//           title: 'Project Management\nDashboard',
//           isSelected: false,
//         ),

//         // Expandable Menu
//         ExpansionTile(
//           leading: Icon(Icons.list, color: Colors.white70),
//           title: Text('Masters', style: TextStyle(color: Colors.white70)),
//           iconColor: Colors.white70,
//           collapsedIconColor: Colors.white70,
//           children: [
//             SubMenuItemWidget(title: 'Initial Figures Job Card'),
//             SubMenuItemWidget(title: 'Facility Master'),
//             SubMenuItemWidget(title: 'Model Master'),
//             SubMenuItemWidget(title: 'Sub Module Master'),
//             SubMenuItemWidget(title: 'Station Master'),
//             SubMenuItemWidget(title: 'Designation Master'),
//           ],
//         ),

//         // More Menu Items
//         ExpansionTile(
//           leading: Icon(Icons.bar_chart, color: Colors.white70),
//           title: Text('Reports', style: TextStyle(color: Colors.white70)),
//           iconColor: Colors.white70,
//           collapsedIconColor: Colors.white70,
//           children: [],
//         ),

//         // Bottom Footer
//         Spacer(),
class MenuItemWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;

  const MenuItemWidget({
    required this.icon,
    required this.title,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Colors.white.withOpacity(0.1) : Colors.transparent,
        border:
            isSelected
                ? Border(left: BorderSide(color: Colors.white, width: 3))
                : null,
        borderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(title, style: TextStyle(color: Colors.white, fontSize: 13)),
        dense: true,
      ),
    );
  }
}

class SubMenuItemWidget extends StatelessWidget {
  final String title;

  const SubMenuItemWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: ListTile(
        leading: Icon(
          Icons.description_outlined,
          color: Colors.white70,
          size: 18,
        ),
        title: Text(
          title,
          style: TextStyle(color: Colors.white70, fontSize: 12),
        ),
        dense: true,
      ),
    );
  }
}

class DashboardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dashboard Title and Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Accounting Dashboard',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  OutlinedButton.icon(
                    icon: Icon(Icons.add),
                    label: Text('Add Dashlet'),
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Color(0xFF5e5cec),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    child: Text('Update Dashboard'),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF5e5cec),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 20),

          // Status Cards
          Row(
            children: [
              StatusCard(
                icon: Icons.calendar_today,
                iconBgColor: Colors.blue.withOpacity(0.1),
                iconColor: Colors.blue,
                title: 'Doctor Appointments',
                version: 'DRAFT',
                isVersionTag: true,
              ),
              SizedBox(width: 10),
              StatusCard(
                icon: Icons.person,
                iconBgColor: Colors.indigo.withOpacity(0.1),
                iconColor: Colors.indigo,
                title: 'Patient Management',
                version: '1.5',
              ),
              SizedBox(width: 10),
              StatusCard(
                icon: Icons.groups,
                iconBgColor: Colors.orange.withOpacity(0.1),
                iconColor: Colors.orange,
                title: 'Staff Management',
                version: '1.0',
              ),
              SizedBox(width: 10),
              StatusCard(
                icon: Icons.work,
                iconBgColor: Colors.cyan.withOpacity(0.1),
                iconColor: Colors.cyan,
                title: 'Leave Management',
                version: 'INACTIVE',
                isVersionTag: true,
              ),
              SizedBox(width: 10),
              StatusCard(
                icon: Icons.people,
                iconBgColor: Colors.teal.withOpacity(0.1),
                iconColor: Colors.teal,
                title: 'Customer Management',
                version: '2.4',
              ),
            ],
          ),

          SizedBox(height: 20),

          // Employee Master & Chart Section
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Employee Master
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.person, color: Colors.blue),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Employee Master',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '2.4',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
                        style: TextStyle(color: Colors.grey[600], height: 1.5),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(width: 20),

              // Client Analysis Chart
              Expanded(
                flex: 4,
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Client analysis chart report - copy',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.open_in_new),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          // We'll implement a custom chart here
                          // or use a chart package like fl_chart
                          Expanded(
                            child: Container(
                              height: 150,
                              child: Center(
                                child: Text(
                                  'Pie Chart Widget Here\n(Use fl_chart package)',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              StatsContainer(
                                number: '4',
                                title: 'Complaints',
                                color: Colors.blue,
                              ),
                              SizedBox(height: 16),
                              StatsContainer(
                                number: '20',
                                title: 'Ahad Workspace',
                                color: Colors.teal,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 20),

          // Task List
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Table Header
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Task Name',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Status',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Due By',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'App/Workspace',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Tags',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Divider(),

                  // Task Items (scrollable list)
                  Expanded(
                    child: ListView(
                      children: [
                        TaskItemWidget(
                          taskName:
                              'Fill and Submit Supplier Quotation Comparison-Supplier',
                          username: 'Alex Rodriguez',
                          date: 'Dec 3, 2020',
                          status: 'Open',
                          statusColor: Colors.blue,
                          dueDate: 'Dec 3, 2020',
                          appIcon: Icons.work,
                          appIconColor: Colors.cyan,
                          appName: 'Leave Management HR',
                          tags: ['Doctor', 'App'],
                        ),
                        Divider(),
                        TaskItemWidget(
                          taskName:
                              'Create Purchase Order App Needs Action for Step 3 with data - Project Nine - NECL Project Nine 2020-2021-1',
                          username: 'Sam Anderson',
                          date: 'Dec 2, 2020',
                          status: 'Overdue',
                          statusColor: Colors.red,
                          dueDate: 'Dec 12, 2020',
                          overdueText: 'Overdue by 1 day',
                          appIcon: Icons.receipt,
                          appIconColor: Colors.blue,
                          appName: 'Manage Orders Events',
                          tags: ['Order', 'Management'],
                        ),
                        Divider(),
                        TaskItemWidget(
                          taskName: 'Quotation Finalised',
                          username: 'Christina Fox',
                          date: 'Apr 29, 2020',
                          status: 'Open',
                          statusColor: Colors.blue,
                          dueDate: 'Sep 27, 2020, 4:00pm',
                          appIcon: Icons.groups,
                          appIconColor: Colors.orange,
                          appName: 'Client Requests Sales',
                          tags: ['Client', 'App'],
                        ),
                        Divider(),
                        TaskItemWidget(
                          taskName:
                              'Fill and Submit Supplier Quotation Comparison-Supplier',
                          username: 'Alex Rodriguez',
                          date: 'Dec 3, 2020',
                          status: 'Open',
                          statusColor: Colors.blue,
                          dueDate: 'Dec 3, 2020',
                          appIcon: Icons.work,
                          appIconColor: Colors.cyan,
                          appName: 'Leave Management HR',
                          tags: ['Doctor', 'App'],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatusCard extends StatelessWidget {
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final String title;
  final String version;
  final bool isVersionTag;

  const StatusCard({
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.title,
    required this.version,
    this.isVersionTag = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: iconColor),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color:
                        isVersionTag
                            ? (version == 'DRAFT'
                                ? Colors.grey.withOpacity(0.2)
                                : Colors.red.withOpacity(0.1))
                            : iconBgColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    version,
                    style: TextStyle(
                      color:
                          isVersionTag
                              ? (version == 'DRAFT'
                                  ? Colors.grey[700]
                                  : Colors.red)
                              : iconColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class StatsContainer extends StatelessWidget {
  final String number;
  final String title;
  final Color color;

  const StatsContainer({
    required this.number,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            number,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(title, style: TextStyle(color: Colors.grey[700], fontSize: 12)),
        ],
      ),
    );
  }
}

class TaskItemWidget extends StatelessWidget {
  final String taskName;
  final String username;
  final String date;
  final String status;
  final Color statusColor;
  final String dueDate;
  final String? overdueText;
  final IconData appIcon;
  final Color appIconColor;
  final String appName;
  final List<String> tags;

  const TaskItemWidget({
    required this.taskName,
    required this.username,
    required this.date,
    required this.status,
    required this.statusColor,
    required this.dueDate,
    this.overdueText,
    required this.appIcon,
    required this.appIconColor,
    required this.appName,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          // Task Name and User
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        taskName,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 10,
                            backgroundImage: NetworkImage(
                              'https://via.placeholder.com/150',
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            '$username • $date',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Status
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Due Date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(dueDate),
                if (overdueText != null)
                  Text(
                    overdueText!,
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
              ],
            ),
          ),

          // App/Workspace
          Expanded(
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: appIconColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(appIcon, color: appIconColor, size: 18),
                ),
                SizedBox(width: 8),
                Expanded(child: Text(appName, style: TextStyle(fontSize: 12))),
              ],
            ),
          ),

          // Tags
          Expanded(
            child: Row(
              children:
                  tags
                      .map(
                        (tag) => Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              tag,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class ClientAnalysisChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Client Type',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Country',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
