package du.board.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import du.board.domain.BoardVO;
import du.common.Pagination;

public interface BoardService {
	public List<BoardVO> selectBoardList(Pagination pagination, String title);
	
	public int selectBoardListCnt(String title);
	
	public void insertBoard(BoardVO board, HttpSession session);
}
