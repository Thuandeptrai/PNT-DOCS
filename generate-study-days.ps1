$ErrorActionPreference = 'Stop'
$root = 'C:\Luyenthi\Requirementlab'
$outRoot = Join-Path $root 'study-days'
New-Item -ItemType Directory -Force -Path $outRoot | Out-Null

$days = @(
  @{d=1; date='2026-08-11'; title='Thiết lập hệ thống và chẩn đoán ban đầu'; learn=@('Cách dùng kho tri thức, kế hoạch học, mind map và nhật ký câu sai','Đánh giá nền tảng Sản phụ khoa ban đầu','Xác định 3 chủ đề yếu nhất'); docs=@('pnt-master-entrance-ai-teacher-kb.md','pnt-master-entrance-study-plan-san-phu-khoa.md','knowledge-mind-map-san-phu-khoa.md','converted-md/san-phu-khoa/__PNT_ TN4000 câu Sản Cơ bản.md'); questions=@('Kỳ thi mục tiêu và chuyên ngành mục tiêu là gì?','File nào là tài liệu học chính cho Sản phụ khoa?','File nào là ngân hàng câu hỏi chính?','File đề cương nào vẫn cần OCR?','Các nhánh lớn trong mind map là gì?','Hiện tại 3 chủ đề yếu nhất là gì?','Vòng học mỗi ngày gồm những bước nào?','Nhật ký câu sai dùng thế nào cho hiệu quả?','Quy định kỳ thi nào vẫn chưa chắc chắn?','AI giáo viên không được tự bịa điều gì?'); drill='Làm 30 câu diagnostic trộn từ TN4000; ghi mọi câu sai hoặc phân vân.'; output=@('Tạo 10 dòng đầu tiên trong nhật ký câu sai','Đánh dấu nhánh yếu trong mind map')},
  @{d=2; date='2026-08-12'; title='Chu kỳ kinh nguyệt và xuất huyết tử cung bất thường'; learn=@('Sinh lý chu kỳ kinh nguyệt','Rối loạn kinh nguyệt','AUB và PALM-COEIN'); docs=@('converted-md/san-phu-khoa/SPK cơ bản _1_.md','converted-md/san-phu-khoa/__PNT_ TN4000 câu Sản Cơ bản.md'); questions=@('Trình bày các pha của chu kỳ kinh nguyệt bình thường.','Hormone nào chiếm ưu thế ở pha nang noãn, rụng trứng và hoàng thể?','Định nghĩa xuất huyết tử cung bất thường.','Giải thích PALM-COEIN.','Bệnh nhân AUB bắt buộc phải hỏi bệnh sử gì?','Cận lâm sàng đầu tay trong AUB là gì?','Khi nào phải loại trừ thai?','Dấu hiệu nào gợi ý ác tính hoặc bệnh nặng?','Phân biệt nguyên nhân cấu trúc và không cấu trúc thế nào?','Xử trí đầu tiên khi chảy máu gây mất ổn định huyết động là gì?'); drill='Làm 30 câu về sinh lý kinh, AUB và nội tiết phụ khoa.'; output=@('Tóm tắt PALM-COEIN 1 trang','Ghi ít nhất 5 lỗi/câu phân vân')},
  @{d=3; date='2026-08-13'; title='Sinh lý thai kỳ và chẩn đoán thai'; learn=@('Thay đổi giải phẫu - sinh lý khi mang thai','Chẩn đoán thai nghén','Ước tính tuổi thai'); docs=@('converted-md/san-phu-khoa/SPK cơ bản _1_.md','converted-md/san-phu-khoa/Sản Huế.md','converted-md/san-phu-khoa/__PNT_ TN4000 câu Sản Cơ bản.md'); questions=@('Thai kỳ làm thay đổi tim mạch như thế nào?','Thai kỳ làm thay đổi hô hấp như thế nào?','Thai kỳ làm thay đổi huyết học như thế nào?','Thay đổi đường tiết niệu nào là sinh lý?','Triệu chứng nào gợi ý có thai nhưng không xác định?','Dấu hiệu có khả năng có thai là gì?','Yếu tố nào xác nhận có thai?','Ước tính tuổi thai sớm bằng cách nào?','Vai trò siêu âm theo từng tam cá nguyệt là gì?','Thay đổi sinh lý nào dễ bị nhầm với bệnh lý?'); drill='Làm 30 câu về sinh lý thai kỳ và chẩn đoán thai.'; output=@('Tạo bảng thay đổi sinh lý thai kỳ','Ghi lỗi vào mistake log')},
  @{d=4; date='2026-08-14'; title='Thai, phần phụ, ngôi thế và chuyển dạ'; learn=@('Thai nhi và phần phụ đủ tháng','Ngôi - thế - kiểu thế','Sinh lý chuyển dạ và biểu đồ chuyển dạ'); docs=@('converted-md/san-phu-khoa/Sản Huế.md','converted-md/san-phu-khoa/SPK cơ bản _1_.md'); questions=@('Định nghĩa ngôi, thế, kiểu thế và độ lọt.','Các đường kính sọ thai quan trọng là gì?','Các giai đoạn chuyển dạ là gì?','Khi nào gọi là chuyển dạ hoạt động?','Biểu đồ chuyển dạ dùng để làm gì?','Dấu hiệu nào gợi ý chuyển dạ bất thường?','Cần theo dõi gì trong chuyển dạ?','Suy thai là gì?','Chỉ định mổ lấy thai thường gặp là gì?','Bước đầu khi chuyển dạ không tiến triển là gì?'); drill='Làm 30 câu về chuyển dạ, ngôi thế và biểu đồ chuyển dạ.'; output=@('Vẽ sơ đồ chuyển dạ bình thường','Ghi các bẫy hay sai')},
  @{d=5; date='2026-08-15'; title='Thi thử ngắn 1'; learn=@('Không học kiến thức mới trước thi thử','Ôn flashcard và lỗi cũ'); docs=@('converted-md/san-phu-khoa/__PNT_ TN4000 câu Sản Cơ bản.md','converted-md/san-phu-khoa/sản ck1 pnt 2026.md'); questions=@('Làm 80 câu trộn có bấm giờ.','10 câu khó nhất là câu nào?','Vì sao đáp án sai lại dễ bị chọn?','Mỗi câu sai rút ra quy tắc gì?','Chủ đề nào xanh, vàng, đỏ?'); drill='80 câu trộn tuần 1, không xem tài liệu.'; output=@('Bảng sửa lỗi thi thử 1','Top 5 chủ đề yếu nhất')},
  @{d=6; date='2026-08-16'; title='Ngày sửa lỗi 1'; learn=@('Vá 2 chủ đề yếu nhất từ thi thử ngắn 1','Học lại định nghĩa và tiêu chuẩn bị quên'); docs=@('converted-md/san-phu-khoa/SPK cơ bản _1_.md','converted-md/san-phu-khoa/Sản Huế.md'); questions=@('5 chủ đề sai nhiều nhất hôm qua là gì?','Mỗi chủ đề thiếu định nghĩa nào?','Tiêu chuẩn chẩn đoán nào bị quên?','Bước xử trí nào chọn quá sớm hoặc quá muộn?','Từ khóa nào trong đề đã bị bỏ sót?','Có giải thích được câu sai mà không nhìn tài liệu không?','Có tự tạo được câu tương tự không?','Lần sau sẽ tránh lỗi này bằng quy tắc nào?'); drill='Làm lại 20 câu thuộc vùng sai.'; output=@('Cập nhật mistake log','Tạo flashcard cho lỗi lặp lại')},
  @{d=7; date='2026-08-17'; title='Giải phẫu hỗ trợ Sản phụ khoa'; learn=@('Khung chậu nữ','Tử cung và phần phụ','Niệu quản - động mạch tử cung','Mạch máu và dây chằng vùng chậu'); docs=@('converted-md/giai-phau/gp nhớ lại _1_.md','converted-md/giai-phau/Trắc nghiệm Giải Phẫu - GS Nguyễn Quang Quyền.md'); questions=@('Xương nào tạo nên khung chậu nữ?','Giới hạn eo trên và eo dưới là gì?','Dây chằng nào nâng đỡ tử cung?','Niệu quản đi gần động mạch tử cung như thế nào?','Ý nghĩa lâm sàng của water under the bridge là gì?','Nguồn cấp máu của tử cung là gì?','Nguồn cấp máu của buồng trứng là gì?','Liên quan giải phẫu của tử cung là gì?','Các lớp của tử cung là gì?','Điểm giải phẫu nào quan trọng khi mổ lấy thai hoặc cắt tử cung?'); drill='25 câu Giải phẫu nếu môn này được xác nhận.'; output=@('Tờ ôn 1 trang giải phẫu chậu nữ')},
  @{d=8; date='2026-08-18'; title='Ra huyết đầu thai kỳ'; learn=@('Dọa sẩy','Sẩy thai','Thai ngoài tử cung','Thai trứng'); docs=@('converted-md/san-phu-khoa/SPK Bệnh _1_.md','converted-md/san-phu-khoa/Sản Huế.md','converted-md/san-phu-khoa/sản ck1 pnt 2026.md'); questions=@('Phân biệt dọa sẩy và sẩy thai khó tránh.','Phân biệt sẩy thai không hoàn toàn và hoàn toàn.','Triệu chứng nào gợi ý thai ngoài tử cung?','Vai trò beta-hCG là gì?','Siêu âm cần tìm gì trong ra huyết đầu thai kỳ?','Điều kiện điều trị MTX trong thai ngoài tử cung là gì?','Khi nào thai ngoài tử cung cần mổ?','Dấu hiệu nào gợi ý thai trứng?','Biến chứng sau thai trứng là gì?','Cần lưu ý Rh như thế nào?'); drill='40 câu về ra huyết đầu thai kỳ.'; output=@('Bảng phân biệt 4 nguyên nhân ra huyết đầu thai kỳ')},
  @{d=9; date='2026-08-19'; title='Tăng huyết áp thai kỳ và tiền sản giật'; learn=@('Tăng huyết áp thai kỳ','Tiền sản giật','Dấu hiệu nặng','Sản giật','HELLP'); docs=@('converted-md/san-phu-khoa/SPK Bệnh _1_.md','converted-md/san-phu-khoa/__PNT_ TN4000 câu Sản Cơ bản.md'); questions=@('Định nghĩa tăng huyết áp thai kỳ.','Định nghĩa tiền sản giật.','Dấu hiệu nặng của tiền sản giật là gì?','Cần làm xét nghiệm gì?','Triệu chứng báo động là gì?','Magnesium sulfate dùng để làm gì?','Dấu hiệu ngộ độc magnesium là gì?','Kiểm soát huyết áp nặng như thế nào?','Khi nào cân nhắc chấm dứt thai kỳ?','Xử trí đầu tiên khi sản giật là gì?'); drill='40 câu và vấn đáp thuật toán magnesium sulfate.'; output=@('Tờ ôn tiền sản giật/sản giật')},
  @{d=10; date='2026-08-20'; title='Đái tháo đường thai kỳ và tăng trưởng thai'; learn=@('Đái tháo đường thai kỳ','Thai chậm tăng trưởng','Thai to','Đánh giá sức khỏe thai'); docs=@('converted-md/san-phu-khoa/SPK Bệnh _1_.md','converted-md/san-phu-khoa/Sản Huế.md'); questions=@('Ai cần tầm soát đái tháo đường thai kỳ?','Nguy cơ cho mẹ là gì?','Nguy cơ cho thai/sơ sinh là gì?','Nguyên tắc điều trị là gì?','Theo dõi đường huyết như thế nào?','Định nghĩa thai chậm tăng trưởng.','Nguyên nhân thai chậm tăng trưởng là gì?','Các phương pháp theo dõi thai là gì?','Thai to là gì?','Thai to làm tăng nguy cơ sinh nào?'); drill='35 câu về đái tháo đường, tăng trưởng thai và theo dõi thai.'; output=@('Bảng nguy cơ mẹ - thai trong đái tháo đường thai kỳ')},
  @{d=11; date='2026-08-21'; title='Xuất huyết nửa sau thai kỳ và sinh non'; learn=@('Nhau tiền đạo','Nhau bong non','Ối vỡ non','Sinh non'); docs=@('converted-md/san-phu-khoa/SPK Bệnh _1_.md','converted-md/san-phu-khoa/Sản Huế.md','converted-md/san-phu-khoa/__PNT_ TN4000 câu Sản Cơ bản.md'); questions=@('So sánh nhau tiền đạo và nhau bong non.','Bệnh nào thường ra huyết không đau?','Bệnh nào thường đau bụng/tăng trương lực tử cung?','Khám nào cần tránh nếu nghi nhau tiền đạo?','Siêu âm xác nhận nhau tiền đạo thế nào?','Nguy cơ mẹ của nhau bong non là gì?','Định nghĩa PROM và PPROM.','Nguy cơ của PPROM là gì?','Dấu hiệu sinh non là gì?','Ưu tiên xử trí trong sinh non là gì?'); drill='40 câu về APH, PPROM và sinh non.'; output=@('Bảng nhau tiền đạo vs nhau bong non')},
  @{d=12; date='2026-08-22'; title='Thi thử ngắn 2 - Cấp cứu sản khoa'; learn=@('Không học mới','Luyện áp dụng có bấm giờ'); docs=@('converted-md/san-phu-khoa/__PNT_ TN4000 câu Sản Cơ bản.md','converted-md/san-phu-khoa/sản ck1 pnt 2026.md'); questions=@('Làm 100 câu tập trung cấp cứu sản khoa.','Câu nào là câu đoán?','Giải thích nhau tiền đạo vs nhau bong non từ trí nhớ.','Giải thích dấu hiệu nặng của tiền sản giật từ trí nhớ.','Giải thích xử trí thai ngoài tử cung từ trí nhớ.'); drill='100 câu có bấm giờ về cấp cứu sản khoa.'; output=@('Bảng sửa thi thử 2','Flashcard cấp cứu')},
  @{d=13; date='2026-08-23'; title='Ngày sửa lỗi 2 - Thuật toán cấp cứu'; learn=@('Sửa lỗi cấp cứu sản khoa','Thuộc bước xử trí đầu tiên'); docs=@('converted-md/san-phu-khoa/SPK Bệnh _1_.md','converted-md/san-phu-khoa/sản ck1 pnt 2026.md'); questions=@('Bước đầu trong băng huyết sau sinh là gì?','4T của băng huyết sau sinh là gì?','Bước đầu trong sản giật là gì?','Bước đầu trong thai ngoài tử cung không ổn định là gì?','Bước đầu khi nghi nhau tiền đạo ra huyết là gì?','Bước đầu trong kẹt vai là gì?','Bước đầu khi nghi nhiễm trùng là gì?','Cấp cứu nào cần gọi hỗ trợ ngay?'); drill='20 câu lặp lại từ lỗi thi thử 2.'; output=@('Tờ thuật toán cấp cứu sản khoa')},
  @{d=14; date='2026-08-24'; title='Băng huyết sau sinh và nhiễm trùng hậu sản'; learn=@('Băng huyết sau sinh','Nhiễm trùng hậu sản','Hậu sản bình thường','Cho con bú và tránh thai sau sinh'); docs=@('converted-md/san-phu-khoa/SPK Bệnh _1_.md','converted-md/san-phu-khoa/Sản Huế.md'); questions=@('Định nghĩa băng huyết sau sinh.','4T là gì?','Đờ tử cung là gì?','Thuốc co hồi tử cung thường dùng là gì?','Nếu xoa đáy tử cung vẫn chảy máu thì kiểm tra gì?','Dấu hiệu nhiễm trùng hậu sản là gì?','Nguồn sốt hậu sản thường gặp là gì?','Đánh giá sản dịch hôi thế nào?','Dấu hiệu nguy hiểm sau sinh là gì?','Tránh thai sau sinh phù hợp gồm gì?'); drill='30 câu về hậu sản.'; output=@('Tờ ôn băng huyết sau sinh')},
  @{d=15; date='2026-08-25'; title='Khí hư bất thường và viêm vùng chậu'; learn=@('Khí hư bất thường','Viêm âm đạo','Viêm cổ tử cung','Viêm vùng chậu','STI'); docs=@('converted-md/san-phu-khoa/SPK cơ bản _1_.md','converted-md/san-phu-khoa/SPK Bệnh _1_.md','converted-md/san-phu-khoa/sản ck1 pnt 2026.md'); questions=@('Cần hỏi bệnh sử gì khi khí hư bất thường?','So sánh nấm Candida, BV và Trichomonas.','Dấu hiệu nào gợi ý viêm cổ tử cung?','Dấu hiệu nào gợi ý PID?','Tiêu chuẩn chẩn đoán PID là gì?','Biến chứng PID là gì?','STI ảnh hưởng sinh sản thế nào?','Nguyên tắc điều trị bạn tình là gì?','Dấu hiệu herpes sinh dục là gì?','Sùi mào gà là gì?'); drill='40 câu về nhiễm trùng và STI.'; output=@('Bảng phân biệt khí hư')},
  @{d=16; date='2026-08-26'; title='AUB, u xơ, lạc nội mạc tử cung'; learn=@('AUB','U xơ tử cung','Lạc nội mạc tử cung','Adenomyosis'); docs=@('converted-md/san-phu-khoa/SPK cơ bản _1_.md','converted-md/san-phu-khoa/SPK Bệnh _1_.md'); questions=@('Nhắc lại PALM-COEIN.','Triệu chứng gợi ý u xơ tử cung là gì?','U xơ gây biến chứng gì?','Cận lâm sàng đánh giá u xơ là gì?','Lạc nội mạc tử cung là gì?','Triệu chứng gợi ý lạc nội mạc tử cung là gì?','Adenomyosis khác lạc nội mạc tử cung thế nào?','Nguyên tắc điều trị lạc nội mạc tử cung là gì?','Khi nào AUB gợi ý ác tính?','Tuổi bệnh nhân làm thay đổi tiếp cận AUB thế nào?'); drill='40 câu về AUB và phụ khoa lành tính.'; output=@('Bảng u xơ vs lạc nội mạc vs adenomyosis')},
  @{d=17; date='2026-08-27'; title='Khối u buồng trứng và vô sinh cơ bản'; learn=@('U nang buồng trứng','Khối u phần phụ','Tiếp cận vô sinh'); docs=@('converted-md/san-phu-khoa/SPK Bệnh _1_.md','converted-md/san-phu-khoa/SPK cơ bản _1_.md','converted-md/san-phu-khoa/sản ck1 pnt 2026.md'); questions=@('Tiếp cận khối u phần phụ thế nào?','Triệu chứng gợi ý xoắn buồng trứng là gì?','Đặc điểm siêu âm nào gợi ý ác tính?','U buồng trứng nào thường lành tính?','U nào có nguy cơ ác tính?','Marker u nào có thể cân nhắc?','Định nghĩa vô sinh.','Nguyên nhân vô sinh nữ là gì?','Cần nghĩ gì về yếu tố nam?','Xét nghiệm đầu tay trong vô sinh là gì?'); drill='35 câu về khối u buồng trứng và vô sinh.'; output=@('Sơ đồ tiếp cận khối u phần phụ')},
  @{d=18; date='2026-08-28'; title='Tầm soát cổ tử cung và ung thư phụ khoa'; learn=@('Pap','HPV','CIN','Ung thư cổ tử cung','Ung thư nội mạc tử cung','Ung thư buồng trứng','Bệnh nguyên bào nuôi'); docs=@('converted-md/san-phu-khoa/SPK Bệnh _1_.md','converted-md/san-phu-khoa/sản ck1 pnt 2026.md'); questions=@('Mục đích Pap là gì?','Vai trò HPV testing là gì?','CIN là gì?','Triệu chứng gợi ý ung thư cổ tử cung là gì?','Triệu chứng gợi ý ung thư nội mạc tử cung là gì?','Triệu chứng gợi ý ung thư buồng trứng là gì?','Bệnh nguyên bào nuôi là gì?','Beta-hCG dùng thế nào sau thai trứng?','Khi thất bại MTX trong bệnh nguyên bào nuôi thì đổi điều trị thế nào?','Dấu hiệu đỏ ung thư trong đề thi là gì?'); drill='40 câu về tầm soát và ung thư.'; output=@('Tờ ôn HPV/Pap/CIN')},
  @{d=19; date='2026-08-29'; title='Thi thử ngắn 3 - Sản phụ khoa hỗn hợp'; learn=@('Không học mới trước thi thử','Luyện tốc độ và phân loại lỗi'); docs=@('converted-md/san-phu-khoa/__PNT_ TN4000 câu Sản Cơ bản.md','converted-md/san-phu-khoa/sản ck1 pnt 2026.md'); questions=@('Làm 120 câu trộn có bấm giờ.','Gắn mỗi câu sai vào một nhánh mind map.','3 kiểu lỗi lặp lại nhiều nhất là gì?','Giải thích một cấp cứu sản khoa bằng miệng.','Giải thích một đường tiếp cận phụ khoa bằng miệng.'); drill='120 câu trộn Sản - Phụ - Ung thư.'; output=@('Bảng sửa thi thử 3','Danh sách bẫy lặp lại')},
  @{d=20; date='2026-08-30'; title='Ngày sửa lỗi 3'; learn=@('Sửa 3 nhánh yếu nhất từ thi thử 3','Phân loại lỗi kiến thức, đọc đề, xử trí'); docs=@('Tài liệu tương ứng với chủ đề sai nhiều nhất'); questions=@('Nhánh nào sai nhiều nhất?','Sai do thiếu kiến thức, hiểu sai hay đọc ẩu?','Định nghĩa nào phải học thuộc?','Tiêu chuẩn chẩn đoán nào phải học thuộc?','Thuật toán nào phải học thuộc?','Có làm lại đúng các câu sai không?','Có giải thích được vì sao đáp án khác sai không?','Nội dung nào cần ôn lại sau 3 ngày?'); drill='30 câu lặp lại từ vùng sai.'; output=@('Cập nhật lỗi lặp lại','Tạo danh sách ôn sau 3 ngày')},
  @{d=21; date='2026-08-31'; title='Tránh thai, dậy thì, PCOS, mãn kinh'; learn=@('Các phương pháp tránh thai','Chống chỉ định thuốc tránh thai phối hợp','Rối loạn dậy thì','PCOS','Mãn kinh'); docs=@('converted-md/san-phu-khoa/SPK cơ bản _1_.md','converted-md/san-phu-khoa/sản ck1 pnt 2026.md'); questions=@('Có những phương pháp tránh thai nào?','Chống chỉ định tránh thai phối hợp là gì?','Sau sinh có thể dùng phương pháp nào?','Tránh thai khẩn cấp là gì?','Dậy thì sớm là gì?','Dậy thì trung ương và ngoại biên khác nhau thế nào?','Khái niệm chẩn đoán PCOS là gì?','Nguy cơ chuyển hóa của PCOS là gì?','Định nghĩa mãn kinh.','Triệu chứng và nguy cơ của mãn kinh là gì?'); drill='35 câu về tránh thai và nội tiết.'; output=@('Bảng chống chỉ định tránh thai phối hợp')},
  @{d=22; date='2026-09-01'; title='Thi thử đầy đủ 1'; learn=@('Không học mới','Thi như thật'); docs=@('converted-md/san-phu-khoa/__PNT_ TN4000 câu Sản Cơ bản.md','converted-md/san-phu-khoa/sản ck1 pnt 2026.md'); questions=@('Làm 120-150 câu trộn có bấm giờ.','Ghi điểm theo nhánh: Sản, Phụ, Ung thư, Giải phẫu.','Đánh dấu câu đúng nhưng còn phân vân.','Viết 10 quy tắc bị bỏ lỡ.','Chọn 5 chủ đề cần sửa ngày mai.'); drill='120-150 câu mô phỏng thi.'; output=@('Bảng sửa thi thử đầy đủ 1')},
  @{d=23; date='2026-09-02'; title='Sửa thi thử đầy đủ 1'; learn=@('Chỉ học phần sai trong thi thử 1','Sửa lỗi theo nhánh mind map'); docs=@('Tài liệu tương ứng với lỗi trong thi thử 1'); questions=@('Nhánh nào sai nhiều nhất?','10 quy tắc bị bỏ lỡ là gì?','Câu nào sai do quên tiêu chuẩn?','Câu nào sai do đọc quá nhanh?','Câu nào sai do không biết bước xử trí đầu tiên?','Có làm lại đúng 20 câu sai nhất không?','5 flashcard nào phải thuộc tối nay?','Chủ đề nào cần đọc lại một lượt?'); drill='50 câu lặp lại hoặc tương tự câu sai.'; output=@('Top 20 câu sai nguy hiểm','5 flashcard bắt buộc')},
  @{d=24; date='2026-09-03'; title='Thi thử đầy đủ 2'; learn=@('Không học mới','Kiểm tra tiến bộ so với thi thử 1'); docs=@('converted-md/san-phu-khoa/__PNT_ TN4000 câu Sản Cơ bản.md','converted-md/san-phu-khoa/sản ck1 pnt 2026.md'); questions=@('Làm 120-150 câu trộn có bấm giờ.','So điểm với thi thử đầy đủ 1.','Đánh dấu lỗi lặp lại.','Đánh dấu chủ đề vẫn chưa an toàn.','Chọn ưu tiên tuần cuối.'); drill='120-150 câu mô phỏng thi.'; output=@('Bảng sửa thi thử đầy đủ 2','Danh sách ưu tiên tuần cuối')},
  @{d=25; date='2026-09-04'; title='Vấn đáp cấp cứu'; learn=@('Chỉ học thuật toán cấp cứu','Tập nói thành quy trình'); docs=@('converted-md/san-phu-khoa/SPK Bệnh _1_.md','converted-md/san-phu-khoa/sản ck1 pnt 2026.md'); questions=@('Xử trí băng huyết sau sinh từng bước.','Xử trí sản giật từng bước.','Xử trí thai ngoài tử cung không ổn định từng bước.','Phân biệt nhau tiền đạo và nhau bong non.','Xử trí nghi nhiễm trùng thai kỳ/hậu sản.','Chỉ định mổ lấy thai cấp cứu là gì?','Dấu hiệu suy thai là gì?','Bước đầu khi kẹt vai là gì?','Dấu hiệu ngộ độc magnesium là gì?','Dấu hiệu đỏ trong ra huyết đầu thai kỳ là gì?'); drill='60 câu mục tiêu về cấp cứu.'; output=@('Thu âm hoặc viết lại 5 thuật toán cấp cứu')},
  @{d=26; date='2026-09-05'; title='Ôn Sản khoa trọng điểm'; learn=@('Chỉ ôn Sản khoa high-yield','Không đọc lan man'); docs=@('converted-md/san-phu-khoa/Sản Huế.md','converted-md/san-phu-khoa/SPK Bệnh _1_.md','converted-md/san-phu-khoa/__PNT_ TN4000 câu Sản Cơ bản.md'); questions=@('Trình bày sinh lý thai kỳ trong 5 phút.','Trình bày các giai đoạn chuyển dạ.','Giải thích biểu đồ chuyển dạ.','Trình bày chẩn đoán phân biệt ra huyết đầu thai kỳ.','Trình bày phân loại tăng huyết áp thai kỳ.','Trình bày nguy cơ đái tháo đường thai kỳ.','Trình bày tiếp cận thai chậm tăng trưởng.','Trình bày chẩn đoán phân biệt APH.','Trình bày xử trí băng huyết sau sinh.','Trình bày đánh giá nhiễm trùng hậu sản.'); drill='80 câu Sản khoa trọng điểm.'; output=@('Tờ ôn Sản khoa cuối cùng')},
  @{d=27; date='2026-09-06'; title='Ôn Phụ khoa và Ung thư trọng điểm'; learn=@('Chỉ ôn Phụ khoa/Ung thư high-yield','Tập tiếp cận triệu chứng'); docs=@('converted-md/san-phu-khoa/SPK cơ bản _1_.md','converted-md/san-phu-khoa/SPK Bệnh _1_.md','converted-md/san-phu-khoa/sản ck1 pnt 2026.md'); questions=@('Trình bày tiếp cận AUB.','Trình bày chẩn đoán phân biệt khí hư.','Trình bày chẩn đoán và biến chứng PID.','Trình bày triệu chứng và nguyên tắc xử trí u xơ.','So sánh lạc nội mạc tử cung và adenomyosis.','Trình bày tiếp cận khối u buồng trứng.','Trình bày logic tầm soát cổ tử cung.','Dấu hiệu đỏ ung thư phụ khoa là gì?','Chống chỉ định tránh thai là gì?','Trình bày PCOS cơ bản.'); drill='80 câu Phụ khoa/Ung thư.'; output=@('Tờ ôn Phụ khoa/Ung thư cuối cùng')},
  @{d=28; date='2026-09-07'; title='Sửa chủ đề yếu cuối cùng'; learn=@('Chỉ sửa lỗi lặp lại','Không mở chương mới'); docs=@('mistake-logs/mistake-log-san-phu-khoa.md','knowledge-mind-map-san-phu-khoa.md','Tài liệu nguồn của lỗi lặp lại'); questions=@('20 lỗi lặp lại nhiều nhất là gì?','10 quy tắc cấp cứu quan trọng nhất là gì?','10 tiêu chuẩn chẩn đoán quan trọng nhất là gì?','10 dấu hiệu đỏ quan trọng nhất là gì?','Câu nào vẫn còn đoán?','Nhánh nào đã mạnh và không cần học thêm?','Sáng mai cần ôn gì?','Giấy tờ và logistics ngày thi cần gì?'); drill='Chỉ làm câu sai và câu còn phân vân.'; output=@('Danh sách ôn sáng cuối','Checklist giấy tờ')},
  @{d=29; date='2026-09-08'; title='Ôn nhẹ cuối cùng'; learn=@('Không học nặng','Không đọc chương mới','Chuẩn bị tinh thần và giấy tờ'); docs=@('mistake-logs/mistake-log-san-phu-khoa.md','knowledge-mind-map-san-phu-khoa.md','Tờ ôn trọng điểm đã tạo'); questions=@('Đọc thuộc thuật toán PPH.','Đọc thuộc thuật toán tiền sản giật/sản giật.','Đọc thuộc chẩn đoán phân biệt ra huyết đầu thai kỳ.','Đọc thuộc chẩn đoán phân biệt APH.','Đọc thuộc AUB/PALM-COEIN.','Đọc thuộc tiêu chuẩn PID.','Đọc thuộc tầm soát cổ tử cung.','Đọc thuộc dấu hiệu đỏ khối u buồng trứng.','Đọc thuộc chống chỉ định tránh thai.','Nếu lo lắng trong phòng thi thì làm gì?'); drill='Chỉ ôn lỗi cũ, không làm đề quá nặng.'; output=@('Chuẩn bị giấy tờ','Ngừng học nặng sớm','Ngủ đủ')}
)

function MdList($items) { ($items | ForEach-Object { "- $_" }) -join "`r`n" }
function JsonArray($items) { ($items | ForEach-Object { $_ }) }

$indexRows = @()
foreach ($day in $days) {
  $folder = Join-Path $outRoot ("day-{0:00}-{1}" -f [int]$day.d, $day.date)
  New-Item -ItemType Directory -Force -Path $folder | Out-Null
  $indexRows += "| Ngày $($day.d) | $($day.date) | [$($day.title)](day-{0:00}-{1}/README.md) |" -f [int]$day.d, $day.date

  $readme = @"
# Ngày $($day.d) - $($day.date) - $($day.title)

## Mục tiêu
$(MdList $day.learn)

## Tài liệu cần đọc
$(MdList $day.docs)

## Bài tập chính
$($day.drill)

## Kết quả cần tạo
$(MdList $day.output)

## Thứ tự học đề xuất
1. Ôn lỗi cũ trong `mistake-logs/mistake-log-san-phu-khoa.md`.
2. Đọc các tài liệu trong mục `Tài liệu cần đọc`.
3. Trả lời câu hỏi trong `questions.md` mà không nhìn tài liệu.
4. Làm bài tập chính.
5. Cập nhật `checklist.md` và ghi lỗi vào mistake log.

## Prompt cho AI giáo viên
Đọc folder ngày này. Dạy đúng chủ đề `$($day.title)`. Hỏi câu hỏi trong `questions.md`, sửa suy luận từng bước, sau đó giao bài tập chính và cập nhật nhật ký câu sai.
"@
  Set-Content -Encoding UTF8 -LiteralPath (Join-Path $folder 'README.md') -Value $readme

  $qLines = for ($i=0; $i -lt $day.questions.Count; $i++) { "{0}. {1}" -f ($i+1), $day.questions[$i] }
  $questions = @"
# Câu hỏi ngày $($day.d) - $($day.title)

## Câu hỏi bắt buộc
$($qLines -join "`r`n")

## Cấu trúc trả lời khuyến nghị

~~~text
Chẩn đoán / khái niệm:
Dấu hiệu chính:
Cận lâm sàng cần có:
Chẩn đoán phân biệt:
Nguyên tắc xử trí đầu tiên:
Bẫy cần tránh:
~~~

## Bài tập trắc nghiệm
$($day.drill)
"@
  Set-Content -Encoding UTF8 -LiteralPath (Join-Path $folder 'questions.md') -Value $questions

  $checklist = @"
# Checklist ngày $($day.d) - $($day.title)

- [ ] Ôn lỗi cũ.
- [ ] Đọc đủ tài liệu được giao.
- [ ] Trả lời toàn bộ câu hỏi trong `questions.md`.
- [ ] Làm bài tập chính: $($day.drill)
- [ ] Ghi câu sai/câu phân vân vào mistake log.
- [ ] Tạo flashcard hoặc tờ ôn nếu có lỗi lặp lại.
- [ ] Ghi lại 3 điều quan trọng nhất học được hôm nay.

## Tự đánh giá cuối ngày

- Mức tự tin hôm nay (0-10):
- Chủ đề yếu nhất hôm nay:
- Câu hỏi cần hỏi lại AI giáo viên:
- Nội dung cần ôn lại sau 3 ngày:
"@
  Set-Content -Encoding UTF8 -LiteralPath (Join-Path $folder 'checklist.md') -Value $checklist

  $obj = [ordered]@{
    day = [int]$day.d
    date = $day.date
    title = $day.title
    learn = @($day.learn)
    docs = @($day.docs)
    questions = @($day.questions)
    drill = $day.drill
    output = @($day.output)
  }
  $obj | ConvertTo-Json -Depth 5 | Set-Content -Encoding UTF8 -LiteralPath (Join-Path $folder 'data.json')
}

$index = @"
# Study Days - PNTU Thạc sĩ Sản phụ khoa

Folder này chia kế hoạch ôn thi thành 29 ngày. Mỗi ngày có:

- `README.md`: mục tiêu, tài liệu, bài tập, prompt cho AI giáo viên.
- `questions.md`: câu hỏi bắt buộc trong ngày.
- `checklist.md`: checklist học và tự đánh giá.
- `data.json`: dữ liệu có cấu trúc để agent đọc tự động.

| Ngày | Ngày tháng | Chủ đề |
|---|---|---|
$($indexRows -join "`r`n")

## Cách dùng

1. Người học mở folder của ngày hiện tại.
2. AI giáo viên đọc `data.json` hoặc `README.md` trước.
3. Người học trả lời `questions.md` không nhìn tài liệu.
4. Sau khi làm câu hỏi, cập nhật `checklist.md` và mistake log.
"@
Set-Content -Encoding UTF8 -LiteralPath (Join-Path $outRoot 'README.md') -Value $index

# Central JSON for agents
$days | ForEach-Object {
  [ordered]@{
    day = [int]$_.d
    date = $_.date
    title = $_.title
    learn = @($_.learn)
    docs = @($_.docs)
    questions = @($_.questions)
    drill = $_.drill
    output = @($_.output)
    folder = ("study-days/day-{0:00}-{1}" -f [int]$_.d, $_.date)
  }
} | ConvertTo-Json -Depth 6 | Set-Content -Encoding UTF8 -LiteralPath (Join-Path $outRoot 'all-days.json')

Write-Host "Generated $($days.Count) study day folders under $outRoot"


