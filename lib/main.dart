import 'package:flutter/material.dart';

void main() => runApp(const LifelineApp());

class LifelineApp extends StatefulWidget {
  const LifelineApp({super.key});
  @override State<LifelineApp> createState() => _LifelineAppState();
}

class _LifelineAppState extends State<LifelineApp> {
  bool _amharic = false;
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Lifeline Ethiopia',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFF9F9FB),
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFCC2637), primary: const Color(0xFFCC2637), surface: Colors.white),
    ),
    home: AppShell(amharic: _amharic, onLanguage: () => setState(() => _amharic = !_amharic)),
  );
}

class Words {
  const Words(this.am);
  final bool am;
  String get home => am ? 'መነሻ' : 'Home';
  String get requests => am ? 'ጥያቄዎች' : 'Requests';
  String get matches => am ? 'ተዛማጆች' : 'Matches';
  String get profile => am ? 'መለያ' : 'Profile';
  String get hello => am ? 'ሰላም፣ ሳራ' : 'Hello, Sara';
  String get hero => am ? 'የእርስዎ ደም ሕይወትን ሊያድን ይችላል' : 'Your blood can save a life';
  String get heroSub => am ? 'ከአቅራቢያዎ ካሉ ሰዎች ጋር ይገናኙ።' : 'Connect with people nearby who need you.';
  String get urgent => am ? 'አስቸኳይ ጥያቄ' : 'Urgent request';
  String get findMatch => am ? 'ተዛማጅ ያግኙ' : 'Find a match';
  String get viewAll => am ? 'ሁሉንም ይመልከቱ' : 'View all';
}

class AppShell extends StatefulWidget {
  const AppShell({super.key, required this.amharic, required this.onLanguage});
  final bool amharic;
  final VoidCallback onLanguage;
  @override State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _tab = 0;
  @override
  Widget build(BuildContext context) {
    final t = Words(widget.amharic);
    return Scaffold(
      body: IndexedStack(index: _tab, children: [HomePage(t: t, onRequests: () => setState(() => _tab = 1), onLanguage: widget.onLanguage), RequestsPage(t: t), MatchesPage(t: t), ProfilePage(t: t, onLanguage: widget.onLanguage)]),
      bottomNavigationBar: NavigationBar(
        height: 74, selectedIndex: _tab, onDestinationSelected: (i) => setState(() => _tab = i),
        destinations: [
          NavigationDestination(icon: const Icon(Icons.home_outlined), selectedIcon: const Icon(Icons.home), label: t.home),
          NavigationDestination(icon: const Icon(Icons.campaign_outlined), selectedIcon: const Icon(Icons.campaign), label: t.requests),
          NavigationDestination(icon: const Icon(Icons.favorite_border), selectedIcon: const Icon(Icons.favorite), label: t.matches),
          NavigationDestination(icon: const Icon(Icons.person_outline), selectedIcon: const Icon(Icons.person), label: t.profile),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.t, required this.onRequests, required this.onLanguage});
  final Words t; final VoidCallback onRequests, onLanguage;
  @override
  Widget build(BuildContext context) => SafeArea(child: SingleChildScrollView(
    padding: const EdgeInsets.fromLTRB(20, 16, 20, 26),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [const BrandMark(size: 44), const SizedBox(width: 11), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(t.hello, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18)), const Row(children: [Icon(Icons.location_on, size: 14, color: Color(0xFF6A6B75)), SizedBox(width: 3), Text('Addis Ababa', style: TextStyle(color: Color(0xFF6A6B75), fontSize: 12))])]), const Spacer(), IconButton(onPressed: onLanguage, tooltip: 'Switch language', icon: Text(t.am ? 'EN' : 'አማ', style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFFCC2637)))), IconButton(onPressed: () => _notifications(context), icon: Badge(label: const Text('2'), child: const Icon(Icons.notifications_none_rounded))) ]),
      const SizedBox(height: 24),
      Container(width: double.infinity, padding: const EdgeInsets.all(22), decoration: BoxDecoration(color: const Color(0xFFCC2637), borderRadius: BorderRadius.circular(28)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Icon(Icons.volunteer_activism, color: Colors.white, size: 34), const SizedBox(height: 18), Text(t.hero, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 25, height: 1.12)), const SizedBox(height: 9), Text(t.heroSub, style: const TextStyle(color: Color(0xFFFFDCE0), fontSize: 14)), const SizedBox(height: 20), FilledButton.icon(onPressed: onRequests, style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: const Color(0xFFB91F31)), icon: const Icon(Icons.search), label: Text(t.findMatch))])),
      const SizedBox(height: 24), SectionTitle(title: t.urgent, action: t.viewAll, onAction: onRequests), const SizedBox(height: 12), UrgentCard(t: t),
      const SizedBox(height: 26), const SectionTitle(title: 'How it works  |  እንዴት ይሰራል?'), const SizedBox(height: 14),
      const Row(children: [Expanded(child: ImpactStep(number: '1', icon: Icons.person_add_alt_1_outlined, label: 'Create\nyour profile')), SizedBox(width: 10), Expanded(child: ImpactStep(number: '2', icon: Icons.radar_outlined, label: 'Get matched\nnearby')), SizedBox(width: 10), Expanded(child: ImpactStep(number: '3', icon: Icons.favorite_outline, label: 'Save a\nlife'))]),
      const SizedBox(height: 24), Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFFFDEEEF), borderRadius: BorderRadius.circular(18)), child: const Row(children: [Icon(Icons.verified_user_outlined, color: Color(0xFFB51E30)), SizedBox(width: 12), Expanded(child: Text('You are eligible to donate', style: TextStyle(fontWeight: FontWeight.w700))), Icon(Icons.chevron_right, color: Color(0xFFB51E30))])),
    ]),
  ));
  void _notifications(BuildContext context) => showModalBottomSheet(context: context, showDragHandle: true, builder: (_) => const Padding(padding: EdgeInsets.fromLTRB(22, 6, 22, 28), child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Notifications', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20)), SizedBox(height: 14), ListTile(contentPadding: EdgeInsets.zero, leading: CircleAvatar(backgroundColor: Color(0xFFFDEEEF), child: Icon(Icons.priority_high, color: Color(0xFFCC2637))), title: Text('Urgent O+ request near you'), subtitle: Text('Tikur Anbessa Hospital · 2 min ago')), ListTile(contentPadding: EdgeInsets.zero, leading: CircleAvatar(backgroundColor: Color(0xFFEAF7F0), child: Icon(Icons.check, color: Color(0xFF188254))), title: Text('You are ready to donate'), subtitle: Text('Your donor profile is verified'))])));
}

class RequestsPage extends StatefulWidget { const RequestsPage({super.key, required this.t}); final Words t; @override State<RequestsPage> createState() => _RequestsPageState(); }
class _RequestsPageState extends State<RequestsPage> {
  String _filter = 'All';
  @override Widget build(BuildContext context) { final items = requests.where((r) => _filter == 'All' || r.type == _filter).toList(); return SafeArea(child: Column(children: [Padding(padding: const EdgeInsets.fromLTRB(20, 18, 20, 10), child: Row(children: [const BrandMark(size: 38), const SizedBox(width: 10), Expanded(child: Text(widget.t.requests, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800))), IconButton(onPressed: () => _form(context), icon: const Icon(Icons.add_circle_outline, color: Color(0xFFCC2637)))])), SizedBox(height: 44, child: ListView(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 20), children: ['All','O+','A+','B+','AB+','O-'].map((x) => Padding(padding: const EdgeInsets.only(right: 8), child: ChoiceChip(label: Text(x), selected: _filter == x, onSelected: (_) => setState(() => _filter = x), selectedColor: const Color(0xFFF8DCE0)))).toList())), const SizedBox(height: 8), Expanded(child: ListView.separated(padding: const EdgeInsets.fromLTRB(20, 8, 20, 22), itemCount: items.length, separatorBuilder: (_, __) => const SizedBox(height: 12), itemBuilder: (_, i) => RequestCard(request: items[i], t: widget.t)))])); }
  void _form(BuildContext context) => showModalBottomSheet(context: context, isScrollControlled: true, showDragHandle: true, builder: (_) => const RequestForm());
}

class MatchesPage extends StatelessWidget { const MatchesPage({super.key, required this.t}); final Words t; @override Widget build(BuildContext context) => SafeArea(child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(t.matches, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800)), const SizedBox(height: 6), const Text('People who match your O+ blood group nearby', style: TextStyle(color: Color(0xFF6A6B75))), const SizedBox(height: 20), Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFFFDEEEF), borderRadius: BorderRadius.circular(18)), child: const Row(children: [Icon(Icons.location_searching, color: Color(0xFFCC2637)), SizedBox(width: 12), Expanded(child: Text('Matching by blood group and distance', style: TextStyle(fontWeight: FontWeight.w700)))])), const SizedBox(height: 18), Expanded(child: ListView.separated(itemCount: matches.length, separatorBuilder: (_, __) => const SizedBox(height: 12), itemBuilder: (_, i) => MatchCard(match: matches[i])))]))); }

class ProfilePage extends StatelessWidget { const ProfilePage({super.key, required this.t, required this.onLanguage}); final Words t; final VoidCallback onLanguage; @override Widget build(BuildContext context) => SafeArea(child: ListView(padding: const EdgeInsets.all(20), children: [Row(children: [Text(t.profile, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800)), const Spacer(), TextButton(onPressed: onLanguage, child: Text(t.am ? 'English' : 'አማርኛ'))]), const SizedBox(height: 14), const Center(child: CircleAvatar(radius: 39, backgroundColor: Color(0xFFF8DCE0), child: Text('SM', style: TextStyle(fontSize: 22, color: Color(0xFFB51E30), fontWeight: FontWeight.w800)))), const SizedBox(height: 12), const Center(child: Text('Sara Mekonnen', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800))), const Center(child: Text('Verified donor · Addis Ababa', style: TextStyle(color: Color(0xFF6A6B75)))), const SizedBox(height: 24), const ProfileStat(), const SizedBox(height: 20), _tile(Icons.bloodtype_outlined, 'Blood group', 'O+'), _tile(Icons.calendar_month_outlined, 'Last donation', '12 May 2026'), _tile(Icons.location_on_outlined, 'Preferred area', 'Bole, Addis Ababa'), _tile(Icons.notifications_active_outlined, 'Urgent request alerts', 'Enabled'), const SizedBox(height: 14), OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.edit_outlined), label: const Text('Edit donor profile')), const SizedBox(height: 8), Center(child: TextButton(onPressed: () {}, child: const Text('Sign out', style: TextStyle(color: Color(0xFF6A6B75)))))])); Widget _tile(IconData icon, String title, String value) => ListTile(contentPadding: const EdgeInsets.symmetric(vertical: 2), leading: CircleAvatar(backgroundColor: const Color(0xFFF6F6F8), child: Icon(icon, color: const Color(0xFFCC2637))), title: Text(title), trailing: Text(value, style: const TextStyle(fontWeight: FontWeight.w700))); }

class BrandMark extends StatelessWidget { const BrandMark({super.key, required this.size}); final double size; @override Widget build(BuildContext context) => Container(width: size, height: size, decoration: BoxDecoration(color: const Color(0xFFCC2637), borderRadius: BorderRadius.circular(size * .32)), child: Icon(Icons.bloodtype_rounded, color: Colors.white, size: size * .6)); }
class SectionTitle extends StatelessWidget { const SectionTitle({super.key, required this.title, this.action, this.onAction}); final String title; final String? action; final VoidCallback? onAction; @override Widget build(BuildContext context) => Row(children: [Text(title, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800)), const Spacer(), if (action != null) TextButton(onPressed: onAction, child: Text(action!))]); }
class BloodBadge extends StatelessWidget { const BloodBadge({super.key, required this.type}); final String type; @override Widget build(BuildContext context) => Container(width: 50, height: 50, decoration: BoxDecoration(color: const Color(0xFFFDEEEF), borderRadius: BorderRadius.circular(14)), alignment: Alignment.center, child: Text(type, style: const TextStyle(color: Color(0xFFBD2032), fontWeight: FontWeight.w900, fontSize: 19))); }
class Detail extends StatelessWidget { const Detail({super.key, required this.icon, required this.text}); final IconData icon; final String text; @override Widget build(BuildContext context) => Row(children: [Icon(icon, size: 16, color: const Color(0xFF6A6B75)), const SizedBox(width: 5), Text(text, style: const TextStyle(fontSize: 12, color: Color(0xFF555661)))]); }
class UrgentPill extends StatelessWidget { const UrgentPill({super.key}); @override Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: const Color(0xFFFDEEEF), borderRadius: BorderRadius.circular(20)), child: const Text('URGENT', style: TextStyle(color: Color(0xFFBE2333), fontSize: 10, fontWeight: FontWeight.w800))); }

class UrgentCard extends StatelessWidget { const UrgentCard({super.key, required this.t}); final Words t; @override Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(17), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), boxShadow: const [BoxShadow(color: Color(0x12000000), blurRadius: 12, offset: Offset(0, 4))]), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [const BloodBadge(type: 'O+'), const SizedBox(width: 13), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Tikur Anbessa Hospital', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)), const SizedBox(height: 3), Text(t.am ? '3 ዩኒት ይፈለጋል · 1.8 km ርቀት' : '3 units needed · 1.8 km away', style: const TextStyle(color: Color(0xFF6A6B75))), const SizedBox(height: 12), const Row(children: [Icon(Icons.schedule, size: 16, color: Color(0xFFCC2637)), SizedBox(width: 4), Text('Needed within 2 hours', style: TextStyle(color: Color(0xFFB51E30), fontWeight: FontWeight.w700))])]))])); }
class ImpactStep extends StatelessWidget { const ImpactStep({super.key, required this.number, required this.icon, required this.label}); final String number, label; final IconData icon; @override Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [CircleAvatar(radius: 13, backgroundColor: const Color(0xFFF8DCE0), child: Text(number, style: const TextStyle(color: Color(0xFFB51E30), fontWeight: FontWeight.w800))), const SizedBox(height: 16), Icon(icon, color: const Color(0xFFCC2637)), const SizedBox(height: 9), Text(label, style: const TextStyle(fontSize: 12, height: 1.25, fontWeight: FontWeight.w700))])); }

class BloodRequest { const BloodRequest(this.type, this.hospital, this.area, this.units, this.urgent, this.time); final String type, hospital, area, units, time; final bool urgent; }
const requests = [BloodRequest('O+', 'Tikur Anbessa Hospital', 'Lideta · 1.8 km', '3 units', true, '2 hours'), BloodRequest('A+', 'St. Paul’s Hospital', 'Gullele · 4.2 km', '2 units', false, 'Today'), BloodRequest('B+', 'Hallelujah General Hospital', 'Megenagna · 5.6 km', '1 unit', true, '4 hours'), BloodRequest('AB+', 'Myungsung Christian Medical Center', 'Gerji · 7.1 km', '2 units', false, 'Tomorrow')];
class RequestCard extends StatelessWidget { const RequestCard({super.key, required this.request, required this.t}); final BloodRequest request; final Words t; @override Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: request.urgent ? const Color(0xFFF2C6CC) : const Color(0xFFE9E9ED))), child: Column(children: [Row(crossAxisAlignment: CrossAxisAlignment.start, children: [BloodBadge(type: request.type), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(request.hospital, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)), const SizedBox(height: 4), Text(request.area, style: const TextStyle(color: Color(0xFF6A6B75)))])), if (request.urgent) const UrgentPill()]), const SizedBox(height: 15), Row(children: [Detail(icon: Icons.water_drop_outlined, text: request.units), const SizedBox(width: 17), Detail(icon: Icons.schedule_outlined, text: request.time), const Spacer(), TextButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Thank you — the hospital has been notified of your offer.'))), child: Text(t.am ? 'እርዳ' : 'I can help'))])])); }

class DonorMatch { const DonorMatch(this.initials, this.name, this.distance, this.type, this.available); final String initials, name, distance, type; final bool available; }
const matches = [DonorMatch('AM', 'Amanuel M.', '1.2 km away', 'O+', true), DonorMatch('HM', 'Hana M.', '2.6 km away', 'O+', true), DonorMatch('DK', 'Daniel K.', '3.4 km away', 'O+', false)];
class MatchCard extends StatelessWidget { const MatchCard({super.key, required this.match}); final DonorMatch match; @override Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)), child: Row(children: [CircleAvatar(radius: 25, backgroundColor: const Color(0xFFF0EEF9), child: Text(match.initials, style: const TextStyle(color: Color(0xFF55468C), fontWeight: FontWeight.w800))), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(match.name, style: const TextStyle(fontWeight: FontWeight.w800)), const SizedBox(height: 3), Text(match.distance, style: const TextStyle(color: Color(0xFF6A6B75), fontSize: 13)), const SizedBox(height: 5), Text(match.available ? 'Available to donate' : 'Available soon', style: TextStyle(color: match.available ? const Color(0xFF168253) : const Color(0xFF9A6418), fontSize: 12, fontWeight: FontWeight.w700))])), BloodBadge(type: match.type)])); }
class ProfileStat extends StatelessWidget { const ProfileStat({super.key}); @override Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(vertical: 17), decoration: BoxDecoration(color: const Color(0xFFCC2637), borderRadius: BorderRadius.circular(20)), child: const Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [Stat(number: '4', label: 'Lives supported'), Stat(number: '3', label: 'Donations'), Stat(number: '98%', label: 'Response rate')])); }
class Stat extends StatelessWidget { const Stat({super.key, required this.number, required this.label}); final String number, label; @override Widget build(BuildContext context) => Column(children: [Text(number, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900)), const SizedBox(height: 3), Text(label, style: const TextStyle(color: Color(0xFFFFDCE0), fontSize: 11))]); }

class RequestForm extends StatefulWidget { const RequestForm({super.key}); @override State<RequestForm> createState() => _RequestFormState(); }
class _RequestFormState extends State<RequestForm> { String group = 'O+'; bool urgent = true; @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.fromLTRB(22, 6, 22, MediaQuery.of(context).viewInsets.bottom + 25), child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Create blood request', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800)), const SizedBox(height: 18), DropdownButtonFormField<String>(value: group, decoration: const InputDecoration(labelText: 'Blood group', border: OutlineInputBorder()), items: ['O+', 'O-', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-'].map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(), onChanged: (v) => setState(() => group = v!)), const SizedBox(height: 12), const TextField(decoration: InputDecoration(labelText: 'Hospital / clinic', hintText: 'e.g. Yekatit 12 Hospital', border: OutlineInputBorder())), SwitchListTile(contentPadding: EdgeInsets.zero, title: const Text('Urgent request'), subtitle: const Text('Notify eligible donors nearby'), value: urgent, activeThumbColor: const Color(0xFFCC2637), onChanged: (v) => setState(() => urgent = v)), SizedBox(width: double.infinity, child: FilledButton(onPressed: () { Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Request submitted. Matching nearby donors…'))); }, child: const Text('Send request')))])); }
