// 食材データ（大幅に拡充）
const foodData = {
    "鶏むね肉":   { P: 23, F: 1.9, C: 0 },
    "鶏もも肉":   { P: 19.2, F: 14.0, C: 0 },
    "卵":        { P: 6.2, F: 5.2, C: 0.2 },
    "ブロッコリー": { P: 3.6, F: 0.4, C: 7.2 },
    "ごはん":     { P: 2.5, F: 0.3, C: 37.1 },
    "鮭":        { P: 20.4, F: 6.3, C: 0 },
    "マグロ":     { P: 26.4, F: 1.4, C: 0 },
    "豆腐":      { P: 6.6, F: 4.2, C: 1.2 },
    "納豆":      { P: 16.5, F: 10.0, C: 12.1 },
    "玄米":      { P: 2.8, F: 1.0, C: 35.6 },
    "さつまいも": { P: 1.4, F: 0.2, C: 30.3 },
    "アボカド":   { P: 2.0, F: 18.7, C: 6.0 },
    "バナナ":     { P: 1.1, F: 0.2, C: 22.8 },
    "りんご":     { P: 0.3, F: 0.1, C: 14.1 },
    "みかん":     { P: 0.8, F: 0.1, C: 11.9 },
    "トマト":     { P: 0.7, F: 0.1, C: 4.7 },
    "きゅうり":   { P: 1.0, F: 0.1, C: 3.9 },
    "レタス":     { P: 1.2, F: 0.2, C: 2.8 },
    "キャベツ":   { P: 1.3, F: 0.2, C: 5.2 },
    "にんじん":   { P: 0.7, F: 0.1, C: 9.3 },
    "玉ねぎ":     { P: 1.0, F: 0.1, C: 8.8 },
    "じゃがいも": { P: 1.6, F: 0.1, C: 17.6 },
    "豚肉":      { P: 20.3, F: 3.3, C: 0.2 },
    "牛肉":      { P: 19.1, F: 15.1, C: 0.1 },
    "サーモン":   { P: 20.4, F: 6.3, C: 0 },
    "イワシ":     { P: 19.8, F: 5.6, C: 0.1 },
    "サバ":      { P: 20.6, F: 12.1, C: 0.1 },
    "エビ":      { P: 20.1, F: 0.5, C: 0.1 },
    "イカ":      { P: 18.1, F: 0.8, C: 0.1 },
    "牛乳":      { P: 3.3, F: 3.6, C: 4.8 },
    "ヨーグルト": { P: 3.6, F: 3.0, C: 4.7 },
    "チーズ":     { P: 22.7, F: 27.4, C: 2.2 },
    "パン":      { P: 8.4, F: 3.1, C: 47.7 },
    "うどん":     { P: 2.6, F: 0.4, C: 21.6 },
    "そば":      { P: 4.8, F: 0.5, C: 26.0 },
    "パスタ":     { P: 12.0, F: 1.5, C: 71.2 },
    "ピーナッツ": { P: 25.4, F: 49.2, C: 18.6 },
    "アーモンド": { P: 20.3, F: 53.8, C: 19.7 },
    "くるみ":     { P: 14.6, F: 64.5, C: 11.7 },
    "ひまわりの種": { P: 20.8, F: 51.5, C: 20.0 },
    "オリーブオイル": { P: 0, F: 100, C: 0 },
    "サラダ油":   { P: 0, F: 100, C: 0 },
    "マヨネーズ": { P: 1.0, F: 75.3, C: 0.7 },
    "ケチャップ": { P: 1.2, F: 0.1, C: 25.6 },
    "醤油":      { P: 8.4, F: 0, C: 4.9 },
    "味噌":      { P: 12.5, F: 6.0, C: 25.7 },
    "砂糖":      { P: 0, F: 0, C: 100 },
    "はちみつ":   { P: 0.3, F: 0, C: 79.7 },
    "コーヒー":   { P: 0.1, F: 0, C: 0.1 },
    "緑茶":      { P: 0.2, F: 0, C: 0.2 },
    "オレンジジュース": { P: 0.7, F: 0.1, C: 10.4 },
    "りんごジュース": { P: 0.1, F: 0.1, C: 11.3 },
    "ビール":     { P: 0.3, F: 0, C: 3.1 },
    "ワイン":     { P: 0.1, F: 0, C: 2.6 },
    "日本酒":     { P: 0.4, F: 0, C: 4.5 }
};

// 合計PFCを管理する変数
let totalP = 0;
let totalF = 0;
let totalC = 0;
let totalCalories = 0;

// カロリー計算関数
function calculateCalories(p, f, c) {
    return (p * 4) + (f * 9) + (c * 4);
}

// ページ読み込み時の初期化
window.onload = function() {
    generateQuickList();
};

// 食材を追加（クイックボタンからのみ呼び出し）
function addFood(foodName) {
    if (!foodName) {
        alert('食材を選択してください');
        return;
    }

    const food = foodData[foodName];
    const calories = calculateCalories(food.P, food.F, food.C);
    
    // テーブルに行を追加
    addTableRow(foodName, food.P, food.F, food.C, calories);
    
    // 合計を更新
    updateTotal(food.P, food.F, food.C, calories);
}

// テーブルに行を追加（食材名をクリック可能にする）
function addTableRow(foodName, p, f, c, calories) {
    const tbody = document.getElementById('foodTableBody');
    const row = tbody.insertRow();
    
    // 食材名セルを作成（クリック可能）
    const nameCell = row.insertCell(0);
    nameCell.textContent = foodName;
    nameCell.className = 'food-name-cell';
    nameCell.onclick = () => deleteRow(row, p, f, c, calories);
    nameCell.title = 'クリックして削除';
    
    // その他のセルを追加
    row.insertCell(1).textContent = p + 'g';
    row.insertCell(2).textContent = f + 'g';
    row.insertCell(3).textContent = c + 'g';
    row.insertCell(4).textContent = Math.round(calories) + 'kcal';
}

// 行を削除して合計を更新
function deleteRow(row, p, f, c, calories) {
    // 合計から減算
    totalP -= p;
    totalF -= f;
    totalC -= c;
    totalCalories -= calories;
    
    // 行を削除
    row.remove();
    
    // 表示を更新
    document.getElementById('totalDisplay').textContent = 
        `今日の合計： P ${totalP.toFixed(1)}g / F ${totalF.toFixed(1)}g / C ${totalC.toFixed(1)}g / カロリー ${Math.round(totalCalories)}kcal`;
}

// 合計を更新
function updateTotal(p, f, c, calories) {
    totalP += p;
    totalF += f;
    totalC += c;
    totalCalories += calories;
    
    // 表示を更新
    document.getElementById('totalDisplay').textContent = 
        `今日の合計： P ${totalP.toFixed(1)}g / F ${totalF.toFixed(1)}g / C ${totalC.toFixed(1)}g / カロリー ${Math.round(totalCalories)}kcal`;
}

// クイックリストを生成（すべての食材をボタンとして表示）
function generateQuickList() {
    const quickList = document.getElementById('quickList');
    
    // 既存のボタンをクリア
    quickList.innerHTML = '';
    
    // すべての食材のボタンを作成
    for (let foodName in foodData) {
        const button = document.createElement('button');
        button.className = 'quick-btn';
        button.textContent = foodName;
        button.onclick = () => addFood(foodName);
        quickList.appendChild(button);
    }
} 