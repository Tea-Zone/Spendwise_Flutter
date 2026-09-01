import 'package:flutter/material.dart';

class DashboardMetricCard
    extends StatelessWidget {
  const DashboardMetricCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),

      child: Padding(
        padding: const EdgeInsets.all(18),

        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,

              decoration: BoxDecoration(
                color: color.withValues(
                  alpha: 0.10,
                ),

                borderRadius:
                BorderRadius.circular(15),

                border: Border.all(
                  color: color.withValues(
                    alpha: 0.20,
                  ),
                ),
              ),

              child: Icon(
                icon,
                color: color,
                size: 22,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [
                  Text(
                    label,

                    style: const TextStyle(
                      color: Color(0xFF91868F),
                      fontSize: 12,
                      fontWeight:
                      FontWeight.w500,
                      letterSpacing: 0.2,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    value,

                    style: const TextStyle(
                      color: Color(0xFFF2E9EF),
                      fontSize: 22,
                      fontWeight:
                      FontWeight.w700,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              Icons.arrow_outward_rounded,
              size: 17,
              color: Colors.white.withValues(
                alpha: 0.16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}