// import 'package:flutter/material.dart';

// class _AnimatedCard extends StatefulWidget {
//   final IconData icon;
//   final String label;
//   final Color color;
//   final VoidCallback onTap;

//   const _AnimatedCard({
//     required this.icon,
//     required this.label,
//     required this.color,
//     required this.onTap,
//   });

//   @override
//   State<_AnimatedCard> createState() => _AnimatedCardState();
// }

// class _AnimatedCardState extends State<_AnimatedCard> {
//   double _scale = 1.0;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: widget.onTap,
//       onTapDown: (_) => setState(() => _scale = 0.95),
//       onTapUp: (_) => setState(() => _scale = 1.0),
//       onTapCancel: () => setState(() => _scale = 1.0),
//       child: AnimatedScale(
//         scale: _scale,
//         duration: Duration(milliseconds: 100),
//         child: Container(
//           decoration: BoxDecoration(
//             color: widget.color,
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.shade400,
//                 offset: Offset(2, 4),
//                 blurRadius: 6,
//               ),
//             ],
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(widget.icon, size: 40, color: Colors.white),
//               SizedBox(height: 10),
//               Text(
//                 widget.label,
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
